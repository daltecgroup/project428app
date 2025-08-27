import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../data/models/Outlet.dart';
import '../data/repositories/outlet_repository.dart';
import '../routes/app_pages.dart';
import '../shared/alert_snackbar.dart';
import '../shared/custom_alert.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';
import '../utils/helpers/text_helper.dart';

class OutletDataController extends GetxController {
  OutletDataController({required this.repository});
  final OutletRepository repository;

  final RxList<Outlet> outlets = <Outlet>[].obs;
  final Rx<Outlet?> selectedOutlet = Rx<Outlet?>(null);
  final Rx<DateTime?> latestSync = (null as DateTime?).obs;
  final RxBool isLoading = false.obs;

  Timer? _syncTimer;

  @override
  void onInit() {
    super.onInit();
    syncData(refresh: true);
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
      LoggerHelper.logInfo('Outlet AutoSync started...');
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
      LoggerHelper.logInfo('Outlet AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_OUTLET_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_OUTLET_LATEST),
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
      final file = await getLocalFile(AppConstants.FILENAME_OUTLET_DATA);
      // if (await file.exists() && refresh != null && refresh == true)
      //   await file.delete();
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo(
          'OUTLET DATA CONT: Set initial outlet from local data',
        );
        final List<Outlet> outletList =
            (json.decode(await file.readAsString()) as List<dynamic>)
                .map((json) => Outlet.fromJson(json as Map<String, dynamic>))
                .toList();
        outletList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        outlets.assignAll(outletList);
      } else {
        LoggerHelper.logInfo(
          'OUTLET DATA CONT: Set initial outlets from server',
        );

        final List<Outlet> fetchedOutlets = await repository.getOutlets();
        if (fetchedOutlets.isNotEmpty) {
          outlets.assignAll(fetchedOutlets);
        } else {
          outlets.clear();
        }

        await file.writeAsString(
          outlets
              .map((outlet) => json.encode(outlet.toJson()))
              .toList()
              .toString(),
        );
        await box.setValue(
          AppConstants.KEY_OUTLET_LATEST,
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

  Future<void> createOutlet(dynamic data) async {
    isLoading.value = true;
    try {
      final response = await repository.createOutlet(data);
      switch (response['statusCode']) {
        case 201:
          successSnackbar(response['message']);
          await syncData(refresh: true);
          Get.offNamed(Routes.OUTLET_LIST);
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

  Future<void> updateOutlet({
    required String id,
    required dynamic data,
    String? backRoute,
  }) async {
    isLoading.value = true;
    try {
      final response = await repository.updateOutlet(id, data);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          selectedOutlet.value = response['outlet'];
          selectedOutlet.refresh();
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
      await updateOutlet(id: id, data: json.encode({'isActive': targetStatus}));
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void deleteConfirmation() async {
    customDeleteAlertDialog(
      'Yakin menghapus ${normalizeName(selectedOutlet.value!.name)}?',
      () {
        Get.back();
        deleteOutlet();
      },
    );
  }

  Future<void> deleteOutlet() async {
    try {
      final response = await repository.deleteOutlet(selectedOutlet.value!.id);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          Get.offNamed(Routes.OUTLET_LIST);
          customSuccessAlertDialog(response['message']);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }

  List<Outlet> filteredOutlet({bool? status, String? keyword}) {
    List<Outlet> filtered = outlets;
    if (status != null) {
      filtered = filtered.where((o) => o.isActive == status).toList();
    }
    if (keyword != null && keyword.isNotEmpty) {
      filtered = filtered
          .where(
            (o) =>
                o.name.toLowerCase().contains(keyword.toLowerCase()) ||
                o.code.toLowerCase().contains(keyword.toLowerCase()),
          )
          .toList();
    }
    return filtered;
  }

  Outlet? getOutletById(String id) {
    return outlets.firstWhereOrNull((outlet) => outlet.id == id);
  }

  List<Outlet> getOutletByOperatorId(String id) {
    return outlets
        .where((outlet) => outlet.operators.contains(id) && outlet.isActive)
        .toList();
  }

  Outlet? get currentOutlet {
    if (box.isNull(AppConstants.KEY_CURRENT_OUTLET) || outlets.isEmpty) {
      return null;
    }
    return getOutletById(box.getValue(AppConstants.KEY_CURRENT_OUTLET));
  }

  String get currentOutletName {
    if (currentOutlet == null) return '';
    return currentOutlet!.name;
  }
}
