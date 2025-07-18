import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../data/models/Order.dart';
import '../data/repositories/order_repository.dart';
import '../routes/app_pages.dart';
import '../shared/alert_snackbar.dart';
import '../shared/custom_alert.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';
import '../utils/helpers/text_helper.dart';

class OrderDataController extends GetxController {
  OrderDataController({required this.repository});
  final OrderRepository repository;

  BoxHelper box = BoxHelper();

  final RxList<Order> orders = <Order>[].obs;
  final Rx<Order?> selectedOrder = Rx<Order?>(null);
  final Rx<DateTime?> latestSync = (null as DateTime?).obs;
  final RxBool isLoading = false.obs;

  Timer? _syncTimer;

  @override
  void onInit() {
    super.onInit();
    syncData();
  }

  @override
  void onReady() {
    super.onReady();
    setLatestSync();
    _startAutoSync();
  }

  @override
  void onClose() {
    super.onClose();
    _stopAutoSync();
  }

  void _startAutoSync() {
    if (AppConstants.RUN_SYNC_TIMER) {
      LoggerHelper.logInfo('Order AutoSync started...');
      _syncTimer = Timer.periodic(Duration(seconds: AppConstants.SYNC_TIMER), (
        timer,
      ) async {
        await syncData(refresh: true);
      });
    }
  }

  void _stopAutoSync() {
    if (_syncTimer != null) {
      _syncTimer!.cancel();
      _syncTimer = null;
      LoggerHelper.logInfo('Order AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_ORDER_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_ORDER_LATEST),
      );
    }
    return time;
  }

  void setLatestSync() {
    latestSync.value = latestSyncTime;
    latestSync.refresh();
  }

  List<Order> filteredOrders(List status, {List<String>? outletId}) {
    return orders.where((order) {
      final matchesStatus = status.contains(order.status);
      final matchesOutlet =
          outletId == null || outletId.contains(order.outlet.outletId);
      return matchesStatus && matchesOutlet;
    }).toList();
  }

  Map<String, List<Order>> groupedOrders(
    List status, {
    List<String>? outletId,
  }) {
    // create a map of order, key is created at in dd mm yyyy local format
    final Map<String, List<Order>> grouped = {};
    final filtered = filteredOrders(status, outletId: outletId);
    for (var order in filtered) {
      final key =
          '${order.createdAt.year}-${order.createdAt.month.toString().padLeft(2, '0')}-${order.createdAt.day.toString().padLeft(2, '0')}';
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(order);
    }
    // sort the map by key in descending order
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => DateTime.parse(b).compareTo(DateTime.parse(a)));
    // create a new map with sorted keys
    final sortedGrouped = <String, List<Order>>{};
    for (var key in sortedKeys) {
      sortedGrouped[key] = grouped[key]!;
    }
    return sortedGrouped;
  }

  Future<void> syncData({bool? refresh}) async {
    isLoading.value = true;
    try {
      final file = await getLocalFile(AppConstants.FILENAME_ORDER_DATA);
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo('Set initial orders from local data');
        final List<Order> orderList =
            (json.decode(await file.readAsString()) as List<dynamic>)
                .map((json) => Order.fromJson(json as Map<String, dynamic>))
                .toList();
        orderList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        orders.assignAll(orderList);
      } else {
        if (await file.exists() && refresh != null && refresh == true)
          await file.delete();
        LoggerHelper.logInfo('Set initial orders from server');

        final List<Order> fetchedOrders = await repository.getOrders();
        if (fetchedOrders.isNotEmpty) {
          orders.assignAll(fetchedOrders);
        } else {
          orders.clear();
        }

        await file.writeAsString(
          json.encode(orders.map((order) => order.toJson()).toList()),
        );
        await box.setValue(
          AppConstants.KEY_ORDER_LATEST,
          DateTime.now().toUtc().toLocal().millisecondsSinceEpoch,
        );
        setLatestSync();
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createOrder(dynamic data, {String? backRoute}) async {
    isLoading.value = true;
    try {
      final response = await repository.createOrder(data);
      switch (response['statusCode']) {
        case 201:
          successSnackbar(response['message']);
          await syncData(refresh: true);
          Get.offNamed(backRoute ?? Routes.ORDER_LIST);
          break;
        default:
          successSnackbar(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateOrder({
    required String id,
    required dynamic data,
    String? backRoute,
  }) async {
    isLoading.value = true;
    try {
      final response = await repository.updateOrder(id, data);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          selectedOrder.value = response['order'];
          selectedOrder.refresh();
          if (backRoute != null) Get.toNamed(backRoute);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> changeStatus(String id, bool targetStatus) async {
    isLoading.value = true;
    try {
      await updateOrder(id: id, data: json.encode({'isActive': targetStatus}));
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void deleteConfirmation() async {
    customDeleteAlertDialog(
      'Yakin menghapus pesanan ${normalizeName(selectedOrder.value!.code)}?',
      () {
        Get.back();
        deleteOrder();
      },
    );
  }

  Future<void> deleteOrder() async {
    try {
      final response = await repository.deleteOrder(selectedOrder.value!.id);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          // Get.offNamed(Routes.OUTLET_LIST);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }
}
