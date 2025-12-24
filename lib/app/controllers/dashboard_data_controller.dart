import 'dart:async';
import 'dart:convert';
import 'package:abg_pos_app/app/data/models/DashboardResponse.dart';
import 'package:abg_pos_app/app/data/repositories/dashboard_repository.dart';
import 'package:get/get.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';

class DashboardDataController extends GetxController {
  DashboardDataController({required this.repository});
  final DashboardRepository repository;

  final Rx<DashboardData?> data = Rx<DashboardData?>(null);
  final Rx<DateTime?> latestSync = (null as DateTime?).obs;
  final RxBool isLoading = false.obs;

  Timer? _syncTimer;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    syncData();
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
      LoggerHelper.logInfo('Dashboard Data AutoSync started...');
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
      LoggerHelper.logInfo('Dashboard Data AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_DASHBOARD_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_DASHBOARD_LATEST),
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
      final file = await getLocalFile(AppConstants.FILENAME_DASHBOARD_DATA);
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo('Set initial dashboard from local data');
        final DashboardData dashboardData = DashboardData.fromJson(
          json.decode(await file.readAsString()),
        );
        data.value = dashboardData;
      } else {
        if (await file.exists() && refresh != null && refresh == true)
          await file.delete();
        LoggerHelper.logInfo('Set initial dashboard from server');

        final DashboardData? fetchedDashboard = await repository.fetchDashboardData(null);
        if (fetchedDashboard != null) {
          data.value = fetchedDashboard;
        await file.writeAsString(
          json.encode(data.value!.toJson()),
        );
        } else {
          data.value = null;
          return;
        } 

        await box.setValue(
          AppConstants.KEY_DASHBOARD_LATEST,
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
