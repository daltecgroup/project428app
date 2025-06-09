import 'package:get/get.dart';
import 'package:project428app/app/services/auth_service.dart';

class SplashController extends GetxController {
  AuthService AuthS = Get.find<AuthService>();
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
    Future.delayed(Duration(milliseconds: 1500)).then((_) {
      if (AuthS.isLoggedIn.value) {
        if (AuthS.userRoles.isEmpty) {
          Get.offNamed('/login');
        } else {
          if (AuthS.userRoles.length == 1) {
            switch (AuthS.userRoles[0]) {
              case 'admin':
                Get.offNamed('/beranda-admin');
                break;
              case 'franchisee':
                Get.offNamed('/homepage-franchisee');
                break;
              case 'spvarea':
                Get.offNamed('/homepage-spvarea');
                break;
              default:
                Get.offNamed('/beranda-operator');
            }
          } else {
            Get.offNamed('/login-as');
          }
        }
      } else {
        Get.offNamed('/login');
      }
    });
  }

  void _startAnimation() async {
    // Animate larger
    await Future.delayed(
      Duration(milliseconds: 700),
    ); // Small delay before animation starts
    // logoSize.value = 0.5; // Make it larger

    // Wait for the first animation to complete, then animate smaller
    await Future.delayed(Duration(milliseconds: 500));
    logoSize.value = 70; // Back to original or slightly smaller

    // You can add navigation to your home screen here after the animation completes
    // For example:
    // await Future.delayed(Duration(milliseconds: 500)); // Additional delay if needed
    // Get.offAll(() => HomePage()); // Replace HomePage with your actual home page
  }
}
