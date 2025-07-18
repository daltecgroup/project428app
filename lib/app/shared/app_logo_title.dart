import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/theme/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppLogoTitle extends StatelessWidget {
  const AppLogoTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 50),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              fit: BoxFit.contain,
              AppConstants.IMG_LOGO,
              width: Get.width * 0.5,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [Text(AppConstants.APP_TITLE, style: AppTextStyle.heading)],
        ),
      ],
    );
  }
}
