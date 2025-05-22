import 'package:flutter/material.dart';

ButtonStyle PrimaryButtonStyle(Color selectedColor) {
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

ButtonStyle LoginAsButtonStyle(Color selectedColor) {
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

InputDecoration MyTextFieldInputDecoration(String hint, Icon? prefixIcon) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    prefixIcon: prefixIcon,
    hintText: hint,
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(color: Colors.transparent),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        style: BorderStyle.none,
        color: Colors.transparent,
      ),
    ),
  );
}

InputDecoration TextFieldDecoration1() {
  return InputDecoration(
    isDense: true,
    filled: true,
    fillColor: Colors.grey[50],
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: Colors.transparent,
      ),
    ),
  );
}

InputDecoration TextFieldDecoration2(
  bool error,
  String? hint,
  Widget? suffixIcon,
) {
  return InputDecoration(
    filled: true,
    isDense: true,
    fillColor: Colors.grey[50],
    hintText: hint,
    suffixIcon: suffixIcon,
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: error ? Colors.red : Colors.grey),
      borderRadius: BorderRadius.circular(8),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide(
        style: BorderStyle.solid,
        color: error ? Colors.red : Colors.transparent,
      ),
    ),
  );
}
