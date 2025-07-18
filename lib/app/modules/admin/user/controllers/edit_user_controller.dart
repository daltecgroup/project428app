import 'dart:convert';
import 'package:abg_pos_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../data/models/User.dart';
import '../../../../shared/alert_snackbar.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../controllers/user_data_controller.dart';

class EditUserController extends GetxController {
  EditUserController({required this.userData});
  UserDataController userData;

  late Rx<User?> _selectedUser;

  // text controllers
  late TextEditingController passwordC;
  late TextEditingController nameC;
  late TextEditingController phoneC;

  // error boolean
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
  RxString passwordErrorText = ''.obs;
  RxString nameErrorText = ''.obs;
  RxString phoneErrorText = ''.obs;

  User? get selectedUser => _selectedUser.value;

  @override
  void onInit() {
    super.onInit();
    passwordC = TextEditingController();
    nameC = TextEditingController();
    phoneC = TextEditingController();
    _selectedUser = userData.selectedUser;
  }

  @override
  void onReady() {
    super.onReady();
    if (selectedUser == null) {
      Get.back();
      alertSnackbar('Gagal membuka detail pengguna');
    } else {
      nameC.text = selectedUser!.name;
      if (selectedUser!.roles.contains(AppConstants.ROLE_ADMIN)) {
        isAdmin.value = true;
      }
      if (selectedUser!.roles.contains(AppConstants.ROLE_FRANCHISEE)) {
        isFranchisee.value = true;
      }
      if (selectedUser!.roles.contains(AppConstants.ROLE_SPVAREA)) {
        isSpvarea.value = true;
      }
      if (selectedUser!.roles.contains(AppConstants.ROLE_OPERATOR)) {
        isOperator.value = true;
      }
      if (selectedUser!.phone != null) phoneC.text = selectedUser!.phone!;
    }
  }

  @override
  void onClose() {
    super.onClose();
    passwordC.dispose();
    nameC.dispose();
    phoneC.dispose();
  }

  bool get isNewData {
    bool isNew = false;
    void setTrue() => isNew = true;

    if (selectedUser!.name != nameC.text.trim()) setTrue();
    if (selectedUser!.phone != null &&
        selectedUser!.phone != phoneC.text.trim())
      setTrue();
    if (selectedUser!.phone == null &&
        phoneC.text.isNotEmpty &&
        phoneC.text != '')
      setTrue();
    if (passwordC.text.isNotEmpty && passwordC.text != '') setTrue();
    if (selectedUser!.roles.contains(AppConstants.ROLE_ADMIN) != isAdmin.value)
      setTrue();
    if (selectedUser!.roles.contains(AppConstants.ROLE_FRANCHISEE) !=
        isFranchisee.value)
      setTrue();
    if (selectedUser!.roles.contains(AppConstants.ROLE_SPVAREA) !=
        isSpvarea.value)
      setTrue();
    if (selectedUser!.roles.contains(AppConstants.ROLE_OPERATOR) !=
        isOperator.value)
      setTrue();

    return isNew;
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

    if (nameC.text.isEmpty) {
      error = true;
      nameError.value = true;
      nameErrorText.value = 'Nama tidak boleh kosong';
    } else if (nameC.text.length < 3) {
      error = true;
      nameError.value = true;
      nameErrorText.value = 'Nama terlalu pendek';
    }

    if (passwordC.text.isNotEmpty && passwordC.text.length < 4) {
      error = true;
      passwordError.value = true;
      passwordErrorText.value = 'PIN harus 4 digit angka';
    }

    return error;
  }

  Future<void> submit() async {
    if (!isNewData) {
      Get.back();
      return;
    }

    if (!isError) {
      List role = [];
      if (isAdmin.value) role.add(AppConstants.ROLE_ADMIN);
      if (isFranchisee.value) role.add(AppConstants.ROLE_FRANCHISEE);
      if (isSpvarea.value) role.add(AppConstants.ROLE_SPVAREA);
      if (isOperator.value) role.add(AppConstants.ROLE_OPERATOR);

      Map<String, dynamic> submitMap = {};
      submitMap['name'] = nameC.text.trim().toLowerCase().capitalize;
      submitMap['roles'] = role;
      if (passwordC.text.isNotEmpty && passwordC.text != '') {
        submitMap['password'] = passwordC.text.trim();
      }
      if (phoneC.text.isNotEmpty && phoneC.text != '') {
        submitMap['phone'] = phoneC.text.trim();
      }

      await userData.updateUser(
        data: json.encode(submitMap),
        backRoute: Routes.USER_DETAIL,
      );
    }
  }
}
