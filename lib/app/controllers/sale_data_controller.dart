import 'dart:async';
import 'dart:convert';

import 'package:abg_pos_app/app/data/models/Sale.dart';
import 'package:abg_pos_app/app/data/repositories/sale_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../routes/app_pages.dart';
import '../shared/alert_snackbar.dart';
import '../shared/custom_alert.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';
import '../utils/helpers/text_helper.dart';

class SaleDataController extends GetxController {
  SaleDataController({required this.repository});
  final SaleRepository repository;

  BoxHelper box = BoxHelper();

  final RxList<Sale> sales = <Sale>[].obs;
  final Rx<Sale?> selectedSale = Rx<Sale?>(null);
  final Rx<DateTime?> latestSync = (null as DateTime?).obs;
  final RxBool isLoading = false.obs;

  RxInt startingDay = 7.obs;

  Timer? _syncTimer;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    syncData(refresh: true);
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
      LoggerHelper.logInfo('Sale AutoSync started...');
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
      LoggerHelper.logInfo('Sale AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_SALE_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_SALE_LATEST),
      );
    }
    return time;
  }

  void setLatestSync() {
    latestSync.value = latestSyncTime;
    latestSync.refresh();
  }

  Future<void> syncData({bool? refresh}) async {
    isLoading.value = true;
    try {
      final file = await getLocalFile(AppConstants.FILENAME_SALE_DATA);
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo('Set initial sales from local data');
        final List<Sale> saleList =
            (json.decode(await file.readAsString()) as List<dynamic>)
                .map((json) => Sale.fromJson(json as Map<String, dynamic>))
                .toList();
        saleList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        sales.assignAll(saleList);
      } else {
        if (await file.exists() && refresh != null && refresh == true)
          await file.delete();
        final currentOutlet = box.getValue(AppConstants.KEY_CURRENT_OUTLET);
        final currentRole = box.getValue(AppConstants.KEY_CURRENT_ROLE);
        String outletQuery = '';
        if (currentRole != null && currentRole == AppConstants.ROLE_OPERATOR) {
          if (currentOutlet != null) {
            outletQuery = '?outletId=$currentOutlet';
          }
        }
        String query =
            '$outletQuery${outletQuery.isEmpty ? '?' : '&'}dateFrom=${DateFormat('yyyy-MM-dd').format(DateTime.now().subtract(Duration(days: startingDay.value)))}';
        LoggerHelper.logInfo('Set initial sales from server');
        LoggerHelper.logInfo('Query: $query');

        final List<Sale> fetchedSales = await repository.getSales(query: query);
        if (fetchedSales.isNotEmpty) {
          sales.assignAll(fetchedSales);
        } else {
          sales.clear();
        }

        await file.writeAsString(
          sales.map((sale) => json.encode(sale.toJson())).toList().toString(),
        );
        await box.setValue(
          AppConstants.KEY_SALE_LATEST,
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

  Future<void> createSale(dynamic data) async {
    isLoading.value = true;
    try {
      final response = await repository.createSale(data);
      switch (response['statusCode']) {
        case 201:
          successSnackbar(response['message']);
          await syncData(refresh: true);
          selectedSale.value = response['sale'];
          selectedSale.refresh();
          Get.offNamed(Routes.OPERATOR_SALE_DETAIL);
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

  Future<void> updateSale({
    required String id,
    dynamic data,
    String? backRoute,
  }) async {
    isLoading.value = true;
    try {
      final response = await repository.updateSale(id, data);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          selectedSale.value = response['sale'];
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
      await updateSale(id: id, data: json.encode({'isValid': targetStatus}));
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void deleteConfirmation() async {
    customDeleteAlertDialog(
      'Yakin menghapus ${normalizeName(selectedSale.value!.code)}?',
      () {
        Get.back();
        deleteSale();
      },
    );
  }

  Future<void> deleteSale() async {
    try {
      final response = await repository.deleteSale(selectedSale.value!.id);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          Get.offNamed(Routes.OPERATOR_SALE);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }

  Sale? getSale(String saleId) {
    return sales.firstWhereOrNull((e) => e.id == saleId);
  }

  List<Sale> getSales({String? outletId}) {
    if (sales.isEmpty) return [];
    if (outletId == null) return sales;
    return sales.where((sale) => sale.outlet.outletId == outletId).toList();
  }

  Map<String, List<Sale>> groupedSales({String? outletId}) {
    // create a map of order, key is created at in dd mm yyyy local format
    final Map<String, List<Sale>> grouped = {};
    for (var sale in getSales(outletId: outletId)) {
      final key =
          '${sale.createdAt.year}-${sale.createdAt.month.toString().padLeft(2, '0')}-${sale.createdAt.day.toString().padLeft(2, '0')}';
      if (!grouped.containsKey(key)) {
        grouped[key] = [];
      }
      grouped[key]!.add(sale);
    }
    // sort the map by key in descending order
    final sortedKeys = grouped.keys.toList()
      ..sort((a, b) => DateTime.parse(b).compareTo(DateTime.parse(a)));
    // create a new map with sorted keys
    final sortedGrouped = <String, List<Sale>>{};
    for (var key in sortedKeys) {
      sortedGrouped[key] = grouped[key]!;
    }
    return sortedGrouped;
  }
}
