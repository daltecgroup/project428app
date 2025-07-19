import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../controllers/auth_controller.dart';
import '../../../../shared/app_logo_title.dart';
import '../../../../shared/custom_card.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/theme/custom_text.dart';
import '../../../../utils/theme/button_style.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Stack(
        children: [
          Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppConstants.DEFAULT_PADDING,
                  ),
                  child: Hero(
                    tag: AppConstants.HERO_AUTH_CARD,
                    child: CustomCard(
                      content: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AppLogoTitle(),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [customTitleText(text: 'Login')],
                            // ),
                            CustomInputWithError(
                              controller: controller.idC,
                              title: 'User ID',
                              hint: 'Masukkan User ID',
                              error: controller.idError.value,
                              errorText: controller.idErrorText.value,
                              onChanged: (value) =>
                                  controller.idError.value = false,
                            ),
                            SizedBox(
                              height: AppConstants.DEFAULT_VERTICAL_MARGIN,
                            ),
                            CustomInputWithError(
                              controller: controller.passwordC,
                              title: 'PIN',
                              hint: 'Masukkan PIN',
                              inputFormatter: [
                                LengthLimitingTextInputFormatter(6),
                              ],
                              maxLines: 1,
                              error: controller.passwordError.value,
                              errorText: controller.passwordErrorText.value,
                              obscure: controller.isObscure.value,
                              inputType: TextInputType.number,
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
                              onChanged: (value) =>
                                  controller.passwordError.value = false,
                            ),
                            SizedBox(
                              height: AppConstants.DEFAULT_VERTICAL_MARGIN,
                            ),
                            Row(
                              children: [
                                Checkbox(
                                  checkColor: Colors.grey[900],
                                  fillColor: WidgetStatePropertyAll(
                                    Colors.blueGrey[200]!,
                                  ),
                                  side: BorderSide(color: Colors.amber[200]!),
                                  value: controller.rememberMe.value,
                                  onChanged: (value) {
                                    controller.rememberMe.value = value!;
                                  },
                                ),
                                customCaptionText(text: 'Ingat saya'),
                              ],
                            ),
                            SizedBox(
                              height: AppConstants.DEFAULT_VERTICAL_MARGIN,
                            ),
                            SizedBox(
                              height: 40,
                              width: double.infinity,
                              child: controller.isLoading.value
                                  ? Center(child: CircularProgressIndicator())
                                  : ElevatedButton(
                                      onPressed: () async {
                                        controller.setRememberMe();
                                        controller.submit();
                                      },
                                      style: primaryButtonStyle(
                                        Colors.grey[700]!,
                                      ),
                                      child: customButtonText(text: 'Masuk'),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
