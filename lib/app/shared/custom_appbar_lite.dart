import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../utils/theme/custom_text.dart';

PreferredSizeWidget customAppBarLite({
  BuildContext? context,
  required String title,
  List<Widget>? actions,
  String? backRoute,
  dynamic result,
  bool enableLeading = true,
}) {
  return AppBar(
    title: customTitleText(text: title),
    centerTitle: true,
    automaticallyImplyLeading: false,
    leading: enableLeading
        ? IconButton(
            onPressed: () => backRoute != null
                ? Get.offNamed(backRoute)
                : Get.back(result: result),
            icon: Icon(
              Icons.arrow_back_ios_new_rounded,
              size: AppConstants.DEFAULT_ICON_SIZE,
            ),
          )
        : null,
    actions: actions,
  );
}
