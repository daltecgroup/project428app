import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/widgets/alert_dialog.dart';
import 'package:project428app/app/widgets/alert_dialog_with_widget.dart';

import '../../../services/user_service.dart';

class UserUpdateController extends GetxController {
  UserService UserS = Get.find<UserService>();
  late TextEditingController idController;
  late TextEditingController nameController;
  late TextEditingController phoneController;

  RxBool status = true.obs;
  RxBool isAdmin = false.obs;
  RxBool isFranchisee = false.obs;
  RxBool isSVPArea = false.obs;
  RxBool isOperator = false.obs;
  RxBool errUserId = false.obs;
  RxBool errName = false.obs;
  RxBool errPeran = false.obs;
  RxBool isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();
    idController = TextEditingController();
    nameController = TextEditingController();
    phoneController = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    idController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  void submitUpdates() {
    final roles = [
      if (isAdmin.value) 'admin',
      if (isFranchisee.value) 'franchisee',
      if (isSVPArea.value) 'spvarea',
      if (isOperator.value) 'operator',
    ];

    if (!errorCheck()) {
      UserS.updateUser(
        UserS.currentUser.value!.id,
        idController.text.trim().toUpperCase(),
        nameController.text.trim().toLowerCase().capitalize,
        phoneController.text,
        roles,
      ).then((success) {
        if (success) {
          Get.back();
        }
      });
    }
  }

  bool errorCheck() {
    bool error = false;
    final errorText = <String>[];

    if (idController.text.isEmpty) {
      errUserId.value = true;
      error = true;
      errorText.add('ID Pengguna tidak boleh kosong');
    }

    if (nameController.text.isEmpty) {
      errName.value = true;
      error = true;
      errorText.add('Nama tidak boleh kosong');
    }

    if (!(isAdmin.value ||
        isFranchisee.value ||
        isSVPArea.value ||
        isOperator.value)) {
      error = true;
      errorText.add('Peran tidak boleh kosong');
    }

    if (error) {
      CustomAlertDialogWithWidget(
        'Peringatan',
        Column(children: errorText.map((e) => Text(e)).toList()),
      );
    }

    return error;
  }

  void assignData() {
    if (UserS.currentUser.value != null) {
      idController.text = UserS.currentUser.value!.userId;
      nameController.text = UserS.currentUser.value!.name;

      for (var role in UserS.currentUser.value!.role) {
        switch (role) {
          case 'admin':
            isAdmin.value = true;
            break;
          case 'franchisee':
            isFranchisee.value = true;
            break;
          case 'spvarea':
            isSVPArea.value = true;
            break;
          default:
            isOperator.value = true;
        }
      }
    }
  }
}
