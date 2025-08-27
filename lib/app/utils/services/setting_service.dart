import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SettingService extends GetxService {
  RxString currentRole = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  ThemeData get currentTheme {
    var selectedColor = Colors.lightBlueAccent;
    switch (currentRole.value) {
      case 'admin':
        selectedColor = Colors.lightBlueAccent;
        break;
      case 'franchisee':
        selectedColor = Colors.amberAccent;
        break;
      case 'spvarea':
        selectedColor = Colors.greenAccent;
        break;
      case 'operator':
        selectedColor = Colors.redAccent;
        break;
      default:
        selectedColor = Colors.blueAccent;
    }

    return ThemeData(
      fontFamily: 'Poppins',
      colorScheme: ColorScheme.fromSeed(
        seedColor: selectedColor,
        brightness: Brightness.light,
      ),
    );
  }
}
