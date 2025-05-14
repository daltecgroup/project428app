import 'package:flutter/material.dart';

ButtonStyle PrimaryButtonStyle(Color selectedColor) {
  return ButtonStyle(
    foregroundColor: WidgetStatePropertyAll(Colors.white),
    backgroundColor: WidgetStatePropertyAll(selectedColor),
    shape: WidgetStatePropertyAll(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(3)),
      ),
    ),
  );
}
