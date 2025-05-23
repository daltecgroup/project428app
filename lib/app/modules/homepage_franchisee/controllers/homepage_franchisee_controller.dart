import 'package:get/get.dart';
import 'package:project428app/app/services/auth_service.dart';

class HomepageFranchiseeController extends GetxController {
  AuthService AuthS = Get.find<AuthService>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
