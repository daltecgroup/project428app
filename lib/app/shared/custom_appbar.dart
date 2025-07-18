import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/theme/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PreferredSizeWidget customAppBar(String title) {
  return AppBar(
    title: customTitleText(text: title),
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
      IconButton(
        icon: Stack(
          children: <Widget>[
            Icon(Icons.notifications),
            // Positioned(top: 0.0, right: 0.0, child: Badge(label: Text("1"))),
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
