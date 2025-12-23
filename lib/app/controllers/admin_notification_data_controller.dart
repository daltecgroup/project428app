import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import '../data/models/AdminNotification.dart';
import '../data/repositories/admin_notification_repository.dart';
import '../shared/custom_alert.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/get_storage_helper.dart';
import '../utils/helpers/logger_helper.dart';

class AdminNotificationDataController extends GetxController {
  AdminNotificationDataController({required this.repository});
  final AdminNotificationRepository repository;

  final RxList<AdminNotification> notifications = <AdminNotification>[].obs;
  final Rx<AdminNotification?> selectedNotification = Rx<AdminNotification?>(
    null,
  );
  final Rx<DateTime?> latestSync = (null as DateTime?).obs;
  final RxBool isLoading = false.obs;

  Timer? _syncTimer;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  Future<void> onReady() async {
    super.onReady();
    await syncData(refresh: true);
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
      LoggerHelper.logInfo('Admin Notifications AutoSync started...');
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
      LoggerHelper.logInfo('Admin Notifications AutoSync stopped...');
    }
  }

  void stopAutoSync() => _stopAutoSync();

  DateTime? get latestSyncTime {
    DateTime? time = null as DateTime?;
    if (!box.isNull(AppConstants.KEY_ADMIN_NOTIFICATION_LATEST)) {
      time = DateTime.fromMillisecondsSinceEpoch(
        box.getValue(AppConstants.KEY_ADMIN_NOTIFICATION_LATEST),
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
      final file = await getLocalFile(
        AppConstants.FILENAME_ADMIN_NOTIFICATION_DATA,
      );
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo('Set initial admin notifications from local data');
        final List<AdminNotification> notificationList =
            (json.decode(await file.readAsString()) as List<dynamic>)
                .map(
                  (json) =>
                      AdminNotification.fromJson(json as Map<String, dynamic>),
                )
                .toList();
        notificationList.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        notifications.assignAll(notificationList);
      } else {
        if (await file.exists() && refresh != null && refresh == true)
          await file.delete();
        LoggerHelper.logInfo('Set initial admin notifications from server');
        final List<AdminNotification> fetchedNotifications = await repository
            .getAllNotifications();
        if (fetchedNotifications.isNotEmpty) {
          notifications.assignAll(fetchedNotifications);
        } else {
          notifications.clear();
        }

        await file.writeAsString(
          notifications
              .map((notification) => json.encode(notification.toJson()))
              .toList()
              .toString(),
        );
        await box.setValue(
          AppConstants.KEY_ADMIN_NOTIFICATION_LATEST,
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

  Future<void> markAsOpen(String id) async {
    try {
      final response = await repository.markAsOpen(id);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }

  Future<void> destroy(String id) async {
    try {
      final response = await repository.destroy(id);
      switch (response['statusCode']) {
        case 200:
          await syncData(refresh: true);
          break;
        default:
          customAlertDialog(response['message']);
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }

  AdminNotification? getNotification(String notificationId) {
    return notifications.firstWhereOrNull((e) => e.id == notificationId);
  }

  int get unreadNotificationCount {
    return notifications.where((e) => e.isOpened == false).length;
  }
}
