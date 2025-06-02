import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/modules/user/controllers/user_controller.dart';
import 'package:random_name_generator/random_name_generator.dart';

import '../../../data/user_provider.dart';

class UserAddController extends GetxController {
  late TextEditingController idController;
  late TextEditingController pinController;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  UserProvider UserP = UserProvider();
  UserController UserC = Get.find<UserController>();

  var randomNames = RandomNames(Zone.us);

  RxBool status = true.obs;
  RxBool isAdmin = false.obs;
  RxBool isFranchisee = false.obs;
  RxBool isSVPArea = false.obs;
  RxBool isOperator = false.obs;
  RxBool errUserId = false.obs;
  RxBool errName = false.obs;
  RxBool errPin = false.obs;
  RxBool errPeran = false.obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    idController = TextEditingController();
    pinController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
    generateId();
    pinController.text = '1234';
    nameController.text = randomNames.manFullName();

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    idController.dispose();
    pinController.dispose();
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }

  void createUser() async {
    isLoading.value = true;
    List role = [];

    if (isAdmin.value) {
      role.add('admin');
    }
    if (isFranchisee.value) {
      role.add('franchisee');
    }
    if (isSVPArea.value) {
      role.add('spvarea');
    }
    if (isOperator.value) {
      role.add('operator');
    }

    try {
      await UserP.createUser(
        idController.text.trim(),
        nameController.text.trim().capitalize!,
        pinController.text.trim(),
        status.value,
        phoneController.text.trim(),
        role,
      ).then((res) async {
        switch (res.statusCode) {
          case 201:
            await UserC.getUsers();
            Get.back();
            break;
          case 400:
            Get.snackbar(kTitleFailed, res.body['message']);
            break;
          default:
            Get.snackbar(kTitleFailed, res.statusText.toString());
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void generateId() {
    String id = '';
    do {
      id = List.generate(6, (_) => Random().nextInt(10)).join();
    } while (id[0] == '0' || id == '000000' || id.length > 6);
    idController.text = id;
  }

  void generatePin() {
    String pin = '';
    do {
      pin = List.generate(4, (_) => Random().nextInt(10)).join();
    } while (pin[0] == '0' || pin == '000000' || pin.length > 4);
    pinController.text = pin;
  }

  void checkPeran() {
    if (isAdmin.value == false &&
        isFranchisee.value == false &&
        isSVPArea.value == false &&
        isOperator.value == false) {
      errPeran.value = true;
    } else {
      errPeran.value = false;
    }
  }

  void checkName() {
    if (nameController.text.isEmpty) {
      errName.value = true;
    } else {
      errName.value = false;
    }
  }

  void checkId() {
    if (idController.text.isEmpty) {
      errUserId.value = true;
    } else {
      errUserId.value = false;
    }
  }

  void checkPin() {
    if (pinController.text.isEmpty) {
      errPin.value = true;
    } else {
      errPin.value = false;
    }
  }

  void submit() {
    checkName();
    checkId();
    checkPin();
    checkPeran();
    if (errName.isFalse &&
        errPeran.isFalse &&
        errUserId.isFalse &&
        errPin.isFalse) {
      print('ready to send');
      createUser();
    }
  }
}
