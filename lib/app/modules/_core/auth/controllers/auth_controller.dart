import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/logger_helper.dart';
import 'package:abg_pos_app/app/utils/services/auth_service.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final AuthService _authS = Get.find<AuthService>();
  BoxHelper box = BoxHelper();
  late TextEditingController idC;
  late TextEditingController passwordC;

  RxBool isObscure = true.obs;
  RxBool isLoading = false.obs;
  RxBool rememberMe = false.obs;

  RxBool idError = false.obs;
  RxBool passwordError = false.obs;
  RxString idErrorText = ''.obs;
  RxString passwordErrorText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    idC = TextEditingController();
    passwordC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
    getRememberMe();
  }

  @override
  void onClose() {
    super.onClose();
    idC.dispose();
    passwordC.dispose();
  }

  void getRememberMe() {
    LoggerHelper.logInfo('getRemberMe initialized');
    if (!box.isNull(AppConstants.KEY_REMEMBER_ME_ID) &&
        !box.isNull(AppConstants.KEY_REMEMBER_ME_PASSWORD)) {
      rememberMe.value = true;
      idC.text = box.getValue(AppConstants.KEY_REMEMBER_ME_ID);
      passwordC.text = box.getValue(AppConstants.KEY_REMEMBER_ME_PASSWORD);
    } else {
      idC.clear();
      passwordC.clear();
    }
  }

  void setRememberMe() {
    LoggerHelper.logInfo('setRememberMe initialized');
    switch (rememberMe.value) {
      case true:
        if (idC.text.isNotEmpty && passwordC.text.isNotEmpty) {
          LoggerHelper.logInfo('ID and PIN saved to local Storage');
          box.setValue(AppConstants.KEY_REMEMBER_ME_ID, idC.text);
          box.setValue(AppConstants.KEY_REMEMBER_ME_PASSWORD, passwordC.text);
        }
        break;
      default:
        LoggerHelper.logInfo('RememberMe cleared!');
        box.removeValue(AppConstants.KEY_REMEMBER_ME_ID);
        box.removeValue(AppConstants.KEY_REMEMBER_ME_ID);
    }
  }

  bool get isError {
    bool error = false;
    if (idC.text.isEmpty) {
      error = true;
      idError.value = true;
      idErrorText.value = 'ID tidak boleh kosong';
    }

    if (passwordC.text.isEmpty) {
      error = true;
      passwordError.value = true;
      passwordErrorText.value = 'Kode PIN tidak boleh kosong';
    }

    if (idC.text.isNotEmpty && idC.text.length < 6) {
      error = true;
      idError.value = true;
      idErrorText.value = 'ID kurang dari 6 digit/karakter';
    }

    return error;
  }

  Future<void> submit() async {
    if (!isError) {
      await _authS.login(idC.text, passwordC.text);
    }
  }
}
