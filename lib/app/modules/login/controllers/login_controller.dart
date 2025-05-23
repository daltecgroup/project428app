import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:project428app/app/services/auth_service.dart';

class LoginController extends GetxController {
  AuthService AuthS = Get.find<AuthService>();

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
    getRememberMe();
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    usernameC.dispose();
    passwordC.dispose();
  }

  void getRememberMe() {
    if (AuthS.box.read('rememberMe') == true) {
      usernameC.text = AuthS.box.read('username');
      rememberMe.value = true;
      print('remember me initiated');
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
      AuthS.login(usernameC.text, passwordC.text);
      // isLoading.value = true;
      // await User.loginUser(usernameC.text, passwordC.text).then((res) {
      //   if (res.statusCode == 200) {
      //     isLoading.value = false;
      //     var data = res.body;
      //     box.write(kUserData, data);
      //     Get.offNamed('login-as');
      //   } else {
      //     print(res.statusText);
      //     if (res.body != null) {
      //       switch (res.body['errorCode']) {
      //         case ErrorCode.invalidCredential:
      //           pinError.value = true;
      //           pinErrorText = 'PIN Salah';
      //           userIDErrorText = res.body['message'];
      //           break;
      //         case ErrorCode.userNotFound:
      //           userIdError.value = true;
      //           userIDErrorText = res.body['message'];
      //           break;
      //         case ErrorCode.innactiveUser:
      //           userIdError.value = true;
      //           userIDErrorText = res.body['message'];
      //           break;
      //         default:
      //           // Get.snackbar(kTitleFailed, res.statusText.toString());
      //           Get.bottomSheet(
      //             CustomBottomSheetWidget(
      //               widget: Column(
      //                 children: [
      //                   TextTitle(text: 'Server Terputus'),
      //                   Text(res.statusText.toString()),
      //                 ],
      //               ),
      //             ),
      //             useRootNavigator: true,
      //           );
      //       }
      //     } else {
      //       Get.bottomSheet(
      //         CustomBottomSheetWidget(
      //           title: 'Server Terputus',
      //           widget: Text(res.statusText.toString()),
      //         ),
      //         useRootNavigator: true,
      //       );
      //     }
      //     isLoading.value = false;
      //   }
      // });
    }
  }

  void setRememberMe() {
    if (usernameC.text != '' && rememberMe.value) {
      AuthS.box.write('username', usernameC.text);
      AuthS.box.write('rememberMe', true);
      print('user id remembered');
    } else {
      AuthS.box.remove('username');
      AuthS.box.remove('rememberMe');
    }
  }
}
