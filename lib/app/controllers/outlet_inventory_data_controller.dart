import 'dart:async';
import 'dart:convert';

import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:get/get.dart';

import '../data/models/OutletInventory.dart';
import '../data/repositories/outlet_inventory_repository.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';

class OutletInventoryDataController extends GetxController {
  OutletInventoryDataController({required this.repository});
  final OutletInventoryRepository repository;

  final Rx<OutletInventory?> selectedOutletInventory = Rx<OutletInventory?>(
    null,
  );
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
    _stopAutoSync();
    super.onClose();
  }

  void _startAutoSync() {
    if (AppConstants.RUN_SYNC_TIMER) {
      LoggerHelper.logInfo('OutletInventory AutoSync started...');
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
      LoggerHelper.logInfo('OutletInventory AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_OUTLET_INVENTORY_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_OUTLET_INVENTORY_LATEST),
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
    if (box.isNull(AppConstants.KEY_CURRENT_OUTLET)) {
      customAlertDialog('Gerai saat ini tidak teridentifikasi.');
      return;
    }

    try {
      final file = await getLocalFile(
        box.getValue(AppConstants.KEY_CURRENT_OUTLET) +
            AppConstants.FILENAME_OUTLET_INVENTORY_DATA,
      );
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo('Set initial outlet inventory from local data');
        final OutletInventory outletInventory = (json.decode(
          await file.readAsString(),
        ));
        selectedOutletInventory.value = outletInventory;
      } else {
        LoggerHelper.logInfo('Set initial outlet inventory from server');

        final fetchedOutlet = await repository.getOutletInventory(
          box.getValue(AppConstants.KEY_CURRENT_OUTLET),
        );
        if (fetchedOutlet != null) {
          selectedOutletInventory.value = fetchedOutlet;
          await file.writeAsString(json.encode(fetchedOutlet.toJson()));
        } else {
          selectedOutletInventory.value = null as OutletInventory?;
        }
        await box.setValue(
          AppConstants.KEY_OUTLET_INVENTORY_LATEST,
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
}
