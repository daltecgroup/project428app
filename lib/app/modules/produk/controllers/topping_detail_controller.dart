import 'package:get/get.dart';
import 'package:project428app/app/modules/produk/controllers/topping_controller.dart';
import 'package:project428app/app/services/auth_service.dart';
import 'package:project428app/app/services/topping_service.dart';

class ToppingDetailController extends GetxController {
  AuthService AuthS = Get.find<AuthService>();
  ToppingController ToppingC = Get.find<ToppingController>();
  ToppingService ToppingS = Get.find<ToppingService>();
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
}
