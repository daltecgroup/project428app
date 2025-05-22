import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/data/user_provider.dart';
import 'package:project428app/app/error_code.dart';
import 'package:project428app/app/widgets/custom_bottom_sheet_widget.dart';
import 'package:project428app/app/widgets/text_header.dart';

class LoginController extends GetxController {
  GetStorage box = GetStorage();
  UserProvider User = UserProvider();

  late TextEditingController usernameC;
  late TextEditingController passwordC;
  var isObscure = true.obs;
  var isLoading = false.obs;

  var userIdError = false.obs;
  var pinError = false.obs;
  var userIDErrorText = '';
  var pinErrorText = '';

  var rememberMe = false.obs;
  var username = '';

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    usernameC = TextEditingController();
    passwordC = TextEditingController();
    passwordC.text = '1234';

    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getRememberMe();
  }

  @override
  void onClose() {
    super.onClose();
    usernameC.dispose();
    passwordC.dispose();
  }

  void getRememberMe() {
    if (box.read('rememberMe') == true) {
      usernameC.text = box.read('username');
      rememberMe.value = true;
    } else {
      usernameC.clear();
      passwordC.clear();
      rememberMe.value = false;
    }
  }

  Future<dynamic> login() async {
    if (usernameC.text.isEmpty || passwordC.text.isEmpty) {
      if (usernameC.text.isEmpty) {
        userIdError.value = true;
        userIDErrorText = "Kolom tidak boleh kosong";
      }
      if (passwordC.text.isEmpty) {
        pinError.value = true;
        pinErrorText = "Kolom tidak boleh kosong";
      }
    } else {
      isLoading.value = true;
      await User.loginUser(usernameC.text, passwordC.text).then((res) {
        if (res.statusCode == 200) {
          isLoading.value = false;
          var data = res.body;
          box.write(kUserData, data);
          Get.offNamed('login-as');
        } else {
          print(res.statusText);
          if (res.body != null) {
            switch (res.body['errorCode']) {
              case ErrorCode.invalidCredential:
                pinError.value = true;
                pinErrorText = 'PIN Salah';
                userIDErrorText = res.body['message'];
                break;
              case ErrorCode.userNotFound:
                userIdError.value = true;
                userIDErrorText = res.body['message'];
                break;
              case ErrorCode.innactiveUser:
                userIdError.value = true;
                userIDErrorText = res.body['message'];
                break;
              default:
                // Get.snackbar(kTitleFailed, res.statusText.toString());
                Get.bottomSheet(
                  CustomBottomSheetWidget(
                    widget: Column(
                      children: [
                        TextTitle(text: 'Server Terputus'),
                        Text(res.statusText.toString()),
                      ],
                    ),
                  ),
                  useRootNavigator: true,
                );
            }
          } else {
            Get.bottomSheet(
              CustomBottomSheetWidget(
                title: 'Server Terputus',
                widget: Text(res.statusText.toString()),
              ),
              useRootNavigator: true,
            );
          }
          isLoading.value = false;
        }
      });
    }
  }

  void setRememberMe() {
    if (usernameC.text != '' && rememberMe.value) {
      box.write('username', usernameC.text);
      box.write('rememberMe', true);
    } else {
      box.remove('username');
      box.remove('rememberMe');
    }
  }
}
