import 'dart:convert';

import 'package:abg_pos_app/app/controllers/user_data_controller.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddUserController extends GetxController {
  AddUserController({required this.userData});
  UserDataController userData;

  // text controllers
  late TextEditingController userIdC;
  late TextEditingController passwordC;
  late TextEditingController nameC;
  late TextEditingController phoneC;

  // error boolean
  RxBool userIdError = false.obs;
  RxBool passwordError = false.obs;
  RxBool nameError = false.obs;
  RxBool phoneError = false.obs;
  RxBool roleError = false.obs;

  // role boolean
  RxBool isAdmin = false.obs;
  RxBool isFranchisee = false.obs;
  RxBool isSpvarea = false.obs;
  RxBool isOperator = false.obs;

  // error text
  RxString userIdErrorText = ''.obs;
  RxString passwordErrorText = ''.obs;
  RxString nameErrorText = ''.obs;
  RxString phoneErrorText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    userIdC = TextEditingController();
    passwordC = TextEditingController();
    nameC = TextEditingController();
    phoneC = TextEditingController();
  }

  @override
  void onClose() {
    super.onClose();
    userIdC.dispose();
    passwordC.dispose();
    nameC.dispose();
    phoneC.dispose();
  }

  bool get isError {
    bool error = false;

    if (isAdmin.value == false &&
        isFranchisee.value == false &&
        isSpvarea.value == false &&
        isOperator.value == false) {
      error = true;
      roleError.value = true;
    } else {
      error = false;
      roleError.value = false;
    }

    if (userIdC.text.isEmpty) {
      error = true;
      userIdError.value = true;
      userIdErrorText.value = 'User ID tidak boleh kosong';
    } else if (userIdC.text.length < 6) {
      error = true;
      userIdError.value = true;
      userIdErrorText.value = 'User ID minimal 6 karakter';
    }

    if (nameC.text.isEmpty) {
      error = true;
      nameError.value = true;
      nameErrorText.value = 'Nama tidak boleh kosong';
    } else if (nameC.text.length < 3) {
      error = true;
      nameError.value = true;
      nameErrorText.value = 'Nama terlalu pendek';
    }

    if (passwordC.text.isEmpty) {
      error = true;
      passwordError.value = true;
      passwordErrorText.value = 'PIN tidak boleh kosong';
    } else if (passwordC.text.isNotEmpty && passwordC.text.length < 4) {
      error = true;
      passwordError.value = true;
      passwordErrorText.value = 'PIN harus 4 digit angka';
    }

    return error;
  }

  Future<void> submit() async {
    if (!isError) {
      List role = [];
      if (isAdmin.value) role.add(AppConstants.ROLE_ADMIN);
      if (isFranchisee.value) role.add(AppConstants.ROLE_FRANCHISEE);
      if (isSpvarea.value) role.add(AppConstants.ROLE_SPVAREA);
      if (isOperator.value) role.add(AppConstants.ROLE_OPERATOR);

      Map<String, dynamic> submitMap = {};
      submitMap['userId'] = userIdC.text.trim();
      submitMap['name'] = nameC.text.trim().toLowerCase().capitalize;
      submitMap['roles'] = role;
      submitMap['password'] = passwordC.text.trim();
      if (phoneC.text.isNotEmpty && phoneC.text != '') {
        submitMap['phone'] = phoneC.text.trim();
      }

      await userData.createUser(json.encode(submitMap));
    }
  }
}
