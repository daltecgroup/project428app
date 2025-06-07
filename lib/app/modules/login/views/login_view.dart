import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project428app/app/style.dart';
import 'package:project428app/app/shared/widgets/app_logo_title_widget.dart';
import 'package:project428app/app/shared/widgets/text_header.dart';

import '../../../core/constants/constants.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: primaryYellow,
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100),
                child: AppLogoTitleWidget(),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 100),
                Hero(
                  tag: 'login-to-select-role',
                  child: Card(
                    color: Colors.white,
                    elevation: 1,
                    margin: EdgeInsets.symmetric(horizontal: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(18),
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Login',
                                    style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              TextTitle(text: 'User ID'),
                              Material(
                                borderRadius: BorderRadius.circular(8),
                                elevation: 2,
                                child: TextField(
                                  controller: controller.usernameC,
                                  decoration: TextFieldDecoration2(
                                    controller.userIdError.value,
                                    'Masukkan User ID',
                                    null,
                                  ),
                                  onChanged:
                                      (value) =>
                                          controller.userIdError.value = false,
                                ),
                              ),
                              TextFieldErrorText(
                                controller.userIdError.value,
                                controller.userIDErrorText,
                              ),
                              const SizedBox(height: 15),
                              TextTitle(text: 'PIN'),
                              Material(
                                borderRadius: BorderRadius.circular(8),
                                elevation: 2,
                                child: TextField(
                                  controller: controller.passwordC,
                                  obscureText: controller.isObscure.value,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                  ],
                                  decoration: TextFieldDecoration2(
                                    controller.pinError.value,
                                    'Masukkan PIN',
                                    IconButton(
                                      icon: Icon(
                                        controller.isObscure.value
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                      ),
                                      onPressed: () {
                                        controller.isObscure.toggle();
                                      },
                                    ),
                                  ),
                                  onChanged:
                                      (value) =>
                                          controller.pinError.value = false,
                                ),
                              ),
                              TextFieldErrorText(
                                controller.pinError.value,
                                controller.pinErrorText,
                              ),

                              Row(
                                children: [
                                  Checkbox(
                                    checkColor: Colors.amber[900],
                                    fillColor: WidgetStatePropertyAll(
                                      Colors.amber[200]!,
                                    ),
                                    side: BorderSide(color: Colors.amber[200]!),
                                    value: controller.rememberMe.value,
                                    onChanged: (value) {
                                      controller.rememberMe.value = value!;
                                    },
                                  ),
                                  Text('Ingat saya'),
                                ],
                              ),

                              const SizedBox(height: 10),
                              Container(
                                height: 40,
                                width: double.infinity,
                                child:
                                    controller.isLoading.value
                                        ? Center(
                                          child: CircularProgressIndicator(),
                                        )
                                        : ElevatedButton(
                                          onPressed: () async {
                                            controller.setRememberMe();
                                            await controller.login();
                                          },
                                          style: PrimaryButtonStyle(
                                            Colors.amber[700]!,
                                          ),
                                          child: const Text('Masuk'),
                                        ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                // SizedBox(height: 200),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget TextFieldErrorText(bool isError, String text) {
    return isError
        ? Text(text, style: TextStyle(fontSize: 12, color: Colors.red))
        : SizedBox();
  }
}
