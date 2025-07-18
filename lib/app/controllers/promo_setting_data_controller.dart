import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../shared/custom_alert.dart';
import '../data/models/PromoSetting.dart';
import '../data/repositories/promo_setting_repository.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';

class PromoSettingDataController extends GetxController {
  PromoSettingDataController({required this.repository});
  final PromoSettingRepository repository;

  BoxHelper box = BoxHelper();

  final RxList<PromoSetting> settings = <PromoSetting>[].obs;
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
      LoggerHelper.logInfo('Promo setting AutoSync started...');
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
      LoggerHelper.logInfo('Promo setting AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_PROMO_SETTING_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_PROMO_SETTING_LATEST),
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
      final file = await getLocalFile(AppConstants.FILENAME_PROMO_SETTING_DATA);
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo('Set initial promo setting from local data');
        final List<PromoSetting> settingList =
            (json.decode(await file.readAsString()) as List<dynamic>)
                .map(
                  (json) => PromoSetting.fromJson(json as Map<String, dynamic>),
                )
                .toList();
        settingList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        settings.assignAll(settingList);
      } else {
        LoggerHelper.logInfo('Set initial promo setting from server');

        final List<PromoSetting> fetchedPromoSettings = await repository
            .getPromoSettings();
        if (fetchedPromoSettings.isNotEmpty) {
          settings.assignAll(fetchedPromoSettings);
        } else {
          settings.clear();
        }

        await file.writeAsString(
          settings
              .map((setting) => json.encode(setting.toJson()))
              .toList()
              .toString(),
        );
        await box.setValue(
          AppConstants.KEY_PROMO_SETTING_LATEST,
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

  Future<void> updatePromoSetting({
    required String id,
    required dynamic data,
    String? backRoute,
  }) async {
    isLoading.value = true;
    try {
      final response = await repository.updatePromoSetting(id, data);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
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
      await updatePromoSetting(
        id: id,
        data: json.encode({'isActive': targetStatus}),
      );
    } catch (e) {
      LoggerHelper.logError(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  PromoSetting? getPromoSetting(String id) {
    return settings.firstWhereOrNull((setting) => setting.id == id);
  }
}
