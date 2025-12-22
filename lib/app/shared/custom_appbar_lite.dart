import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../utils/theme/custom_text.dart';

PreferredSizeWidget customAppBarLite({
  BuildContext? context,
  String? title,
  String? subtitle,
  List<Widget>? actions,
  String? backRoute,
  dynamic result,
  bool enableLeading = true,
  Widget? titleWidget
}) {
  return AppBar(
    title: titleWidget ?? Column(
      children: [
        customTitleText(
          text: title??'',
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
