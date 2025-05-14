import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/style.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          width: kMobileWidth * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                kMainTitle,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 100),
              Text('Login', style: TextStyle(fontSize: 20)),
              const SizedBox(height: 20),
              Obx(
                () => TextField(
                  controller: controller.usernameC,
                  decoration: InputDecoration(
                    labelText: 'ID Number/Username',
                    border: OutlineInputBorder(),
                    errorText:
                        controller.userIdError.value
                            ? controller.errorText
                            : null,
                  ),
                  onChanged: (value) => controller.userIdError.value = false,
                ),
              ),
              const SizedBox(height: 10),
              Obx(
                () => TextField(
                  controller: controller.passwordC,
                  obscureText: controller.isObscure.value,
                  keyboardType: TextInputType.number,
                  inputFormatters: [LengthLimitingTextInputFormatter(6)],
                  decoration: InputDecoration(
                    labelText: 'PIN',
                    border: OutlineInputBorder(),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isObscure.value
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        controller.isObscure.toggle();
                      },
                    ),
                    errorText:
                        controller.pinError.value ? controller.errorText : null,
                  ),
                  onChanged: (value) => controller.pinError.value = false,
                ),
              ),
              Obx(
                () => Row(
                  children: [
                    Checkbox(
                      value: controller.rememberMe.value,
                      onChanged: (value) {
                        controller.rememberMe.value = value!;
                      },
                    ),
                    Text('Ingat saya'),
                  ],
                ),
              ),

              const SizedBox(height: 20),
              Container(
                height: 40,
                width: double.infinity,
                child: Obx(
                  () =>
                      controller.isLoading.value
                          ? Center(child: CircularProgressIndicator())
                          : ElevatedButton(
                            onPressed: () async {
                              controller.setRememberMe();
                              await controller.login();
                            },
                            style: PrimaryButtonStyle(Colors.blueAccent),
                            child: const Text('Login'),
                          ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
