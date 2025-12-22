import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:abg_pos_app/app/shared/custom_appbar_lite.dart';
import 'package:abg_pos_app/app/shared/custom_nav_item.dart';
import 'package:abg_pos_app/app/shared/horizontal_sized_box.dart';
import 'package:abg_pos_app/app/shared/vertical_sized_box.dart';
import 'package:abg_pos_app/app/utils/constants/padding_constants.dart';
import 'package:abg_pos_app/app/utils/constants/string_value.dart';
import 'package:abg_pos_app/app/utils/helpers/time_helper.dart';
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
          IconButton(onPressed: () {}, icon: Icon(Icons.refresh)),
          HorizontalSizedBox(),
        ],
      ),
      body: ListView(
        padding: horizontalPadding,
        children: [
          VerticalSizedBox(height: 2),
          CustomNavItem(
            marginBottom: true,
            leading: Icon(Icons.delete_outline),
            disableTrailing: true,
            titleWidget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Permintaan Hapus'),
                    HorizontalSizedBox(width: 0.7),
                    Badge(
                      backgroundColor: Colors.red.shade700,
                      label: Text('Baru'),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    ),
                  ],
                ),
                customSmallLabelText(text: localTimeFormat(DateTime.now())),
              ],
            ),
            subTitle: 'Meminta penghapusan penjualan 20204202340',
            onTap: () {
              Get.toNamed(
                Routes.NOTIFICATION_DETAIL,
                arguments: {
                  'title': 'Gerai 1',
                  'detail': 'Meminta penghapusan penjualan 20204202340',
                  'status': 'Baru',
                  'createdAt': localTimeFormat(DateTime.now()),
                },
              );
            },
          ),
          CustomNavItem(
            marginBottom: true,
            leading: Icon(Icons.delete_outline),
            disableTrailing: true,
            titleWidget: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text('Permintaan Hapus'),
                    HorizontalSizedBox(width: 0.7),
                    Badge(
                      backgroundColor: Colors.grey.shade200,
                      textColor: Colors.grey.shade700,
                      label: Text('Dibaca'),
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                    ),
                  ],
                ),
                customSmallLabelText(text: localTimeFormat(DateTime.now())),
              ],
            ),
            subTitle: 'Meminta penghapusan penjualan 20204202340',
            onTap: () {
              Get.toNamed(Routes.NOTIFICATION_DETAIL, arguments: {
                  'title': 'Gerai 2',
                  'detail': 'Meminta penghapusan penjualan 20204202340',
                  'status': 'Baru',
                  'createdAt': localTimeFormat(DateTime.now()),
                },);
            },
          ),
        ],
      ),
    );
  }
}
