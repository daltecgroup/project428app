import 'package:get/get.dart';
import 'package:project428app/app/services/auth_service.dart';
import 'package:project428app/app/services/operator_service.dart';
import 'package:project428app/app/services/personalization_service.dart';

class LoginAsController extends GetxController {
  Personalization c = Get.find<Personalization>();
  OperatorService operatorS = Get.put(OperatorService());
  AuthService AuthS = Get.put(AuthService());

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
