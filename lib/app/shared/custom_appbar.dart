import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/user_helper.dart';
import 'package:abg_pos_app/app/utils/services/notification_service.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget customAppBar(
  String title, {
  String? subtitle,
  IconButton? actionButton,
}) {

  
  return AppBar(
    title: Column(
      children: [
        customTitleText(
          text: title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        if (subtitle != null)
          customSmallLabelText(
            text: subtitle,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
      ],
    ),
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: Builder(
      builder: (context) {
        return IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
        );
      },
    ),
    actions: [
      actionButton ??
          IconButton(
            icon: Stack(
              children: <Widget>[
                Icon(Icons.notifications),
                NotificationIndicatorBadge(),
              ],
            ),
            onPressed: () {
              Get.toNamed(Routes.NOTIFICATION);
            },
          ),
      SizedBox(width: AppConstants.DEFAULT_PADDING),
    ],
  );
}

class NotificationIndicatorBadge extends StatelessWidget {
  NotificationIndicatorBadge({
    super.key,
  });

  final NotificationService notifService = Get.find<NotificationService>();

  @override
  Widget build(BuildContext context) {
    return Obx(
    () {
      int count = notifService.unreadNotificationCount;
        if(isAdmin) return count>0? Positioned(top: 0.0, right: 0.0, child: Badge(label: Text(count.toString()))): const SizedBox.shrink();
        return notifService.currentNotificationCount.value > 0 ? Positioned(top: 0.0, right: 0.0, child: Badge(label: Text(notifService.currentNotificationCount.value.toString()))) : const SizedBox.shrink();
      }
    );
  }
}
