import 'package:abg_pos_app/app/controllers/admin_notification_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/admin_notification_provider.dart';
import 'package:abg_pos_app/app/data/repositories/admin_notification_repository.dart';
import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationBinding extends Bindings {
  @override
  void dependencies() {
    // request data
    Get.lazyPut<AdminNotificationProvider>(() => AdminNotificationProvider());
    Get.lazyPut<AdminNotificationRepository>(
      () => AdminNotificationRepository(provider: Get.find<AdminNotificationProvider>()),
    );
    Get.lazyPut<AdminNotificationDataController>(
      () => AdminNotificationDataController(repository: Get.find<AdminNotificationRepository>()),
    );

    Get.lazyPut<NotificationController>(
      () => NotificationController(adminNotif: Get.find<AdminNotificationDataController>()),
    );
  }
}
