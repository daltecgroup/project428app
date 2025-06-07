import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../core/constants/constants.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Or your desired background color
      body: Center(
        child: Obx(
          () => AnimatedScale(
            scale: controller.logoSize.value,
            duration: const Duration(milliseconds: 500),
            curve: Curves.easeInOut, // Smooth animation curve
            child: Image.asset(
              'assets/lekerlondo_small.png', // Your logo path
              width: kMobileWidth * 0.7, // Adjust size as needed
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
