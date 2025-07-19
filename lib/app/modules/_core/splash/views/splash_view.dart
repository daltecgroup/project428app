import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.asset(
          width: Get.width * 0.5,
          AppConstants.IMG_LOGO_BW, // Adjust size as needed
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
