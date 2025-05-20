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

InputDecoration MyTextFieldInputDecoration(String hint, Icon prefixIcon) {
  return InputDecoration(
    filled: true,
    fillColor: Colors.white,
    prefixIcon: prefixIcon,
    hintText: hint,
    focusedBorder: OutlineInputBorder(
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

InputDecoration TextFieldDecoration2(bool error) {
  return InputDecoration(
    filled: true,
    isDense: true,
    fillColor: Colors.grey[50],
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
