import 'package:abg_pos_app/app/utils/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ButtonStyle primaryButtonStyle(Color selectedColor) {
  return ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Colors.white),
    backgroundColor: WidgetStatePropertyAll(selectedColor),
    splashFactory: InkSplash.splashFactory,
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    ),
  );
}

ButtonStyle nextButtonStyle() {
  return ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    backgroundColor: WidgetStateProperty.all(Get.theme.primaryColor),
  );
}

ButtonStyle errorButtonStyle() {
  return ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    backgroundColor: WidgetStateProperty.all(AppColors.error),
  );
}

ButtonStyle backButtonStyle() {
  return ButtonStyle(
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    ),
    backgroundColor: WidgetStateProperty.all(Get.theme.primaryColorLight),
  );
}

ButtonStyle selectRoleButtonStyle(Color selectedColor) {
  return ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Colors.white),
    backgroundColor: WidgetStatePropertyAll(selectedColor),
    splashFactory: InkSplash.splashFactory,
    padding: WidgetStatePropertyAll(EdgeInsets.all(12)),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5)),
      ),
    ),
  );
}
