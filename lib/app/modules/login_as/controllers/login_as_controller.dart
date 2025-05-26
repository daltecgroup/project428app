import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/services/auth_service.dart';
import 'package:project428app/app/services/operator_service.dart';

class LoginAsController extends GetxController {
  OperatorService OperatorS = Get.find<OperatorService>();
  AuthService AuthS = Get.put(AuthService());

  @override
  Future<void> onInit() async {
    super.onInit();
    if (AuthS.hasRole('operator')) {
      await OperatorS.setCurrentOutlet(AuthS.box.read('userProfile')['id']);
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> loginAsOperator() async {
    await OperatorS.setCurrentOutlet(AuthS.box.read('userProfile')['id']).then((
      res,
    ) {
      if (OperatorS.isAssignToOutlet.value) {
        AuthS.currentRoleTheme.value = 'operator';
        Get.offNamed('/beranda-operator');
      } else {
        Get.defaultDialog(
          backgroundColor: Colors.white,
          title: "Peringatan",
          titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          radius: 8,
          content: Text('Operator belum ditugaskan ke Gerai'),
        );
      }
    });
  }
}
