import 'package:abg_pos_app/app/data/models/AdminNotification.dart';
import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/custom_nav_item.dart';
import 'package:abg_pos_app/app/shared/horizontal_sized_box.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/constants/string_value.dart';
import 'package:abg_pos_app/app/utils/helpers/time_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/user_helper.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBarLite(
        title: StringValue.NOTIFICATION,
        actions: [
          IconButton(
            onPressed: () => controller.adminNotif.syncData(refresh: true),
            icon: Icon(Icons.refresh),
          ),
          HorizontalSizedBox(),
        ],
      ),
      body: Obx(() {
        final adminNotifications = controller.adminNotif.notifications;
        return ListView(
          padding: horizontalPadding,
          children: [
            VerticalSizedBox(height: 2),
            if (isAdmin) ...[
              ...adminNotifications.map(
                (item) => AdminNotificationItem(notification: item, controller: controller,),
              ),
            ],

            if (!isAdmin) ...[
              if (controller.adminNotif.notifications.isNotEmpty) ...[
                Container(),
              ],
            ],
          ],
        );
      }),
    );
  }
}

class AdminNotificationItem extends StatelessWidget {
  const AdminNotificationItem({super.key, required this.notification, required this.controller});

  final AdminNotification notification;
  final NotificationController controller;

  @override
  Widget build(BuildContext context) {
    return CustomNavItem(
      marginBottom: true,
      leading: Icon(Icons.notifications),
      disableTrailing: true,
      titleWidget: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(notification.type.capitalize!),
              HorizontalSizedBox(width: 0.7),
              Badge(
                backgroundColor: notification.isOpened
                    ? Colors.grey.shade400
                    : Colors.red.shade700,
                label: notification.isOpened ? Text('Dibaca') : Text('Baru'),
                padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              ),
            ],
          ),
          customSmallLabelText(text: localTimeFormat(DateTime.now())),
        ],
      ),
      subTitle: notification.content,
      onTap: () async {
        await controller.adminNotif.markAsOpen(notification.id);
        Get.toNamed(
          Routes.NOTIFICATION_DETAIL,
          arguments: {
            'title': notification.type.capitalize,
            'detail': notification.content,
            'status': notification.isOpened ? 'Dibaca' : 'Baru',
            'createdAt': notification.createdAt.toIso8601String(),
            'outlet': notification.outlet.name,
          },
        );
      },
    );
  }
}
