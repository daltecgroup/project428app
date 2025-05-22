import 'package:get/get.dart';

class SplashController extends GetxController {
  RxDouble logoSize = 0.5.obs; // Initial size for animation

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    _startAnimation();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void _startAnimation() async {
    // Animate larger
    await Future.delayed(
      Duration(milliseconds: 100),
    ); // Small delay before animation starts
    logoSize.value = 0.7; // Make it larger

    // Wait for the first animation to complete, then animate smaller
    await Future.delayed(Duration(milliseconds: 500));
    logoSize.value = 0.5; // Back to original or slightly smaller

    // You can add navigation to your home screen here after the animation completes
    // For example:
    // await Future.delayed(Duration(milliseconds: 500)); // Additional delay if needed
    // Get.offAll(() => HomePage()); // Replace HomePage with your actual home page
  }
}
