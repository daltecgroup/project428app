import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/models/user_data.dart';

class Personalization extends GetxService {
  GetStorage box = GetStorage();
  late User userdata;

  final connectionChecker = InternetConnectionChecker.instance;

  Rx<ThemeData> theme = ThemeData.light().obs;
  var isDarkMode = false.obs;
  var isConnected = true.obs;

  var currentRoleTheme = 'admin'.obs;

  @override
  void onInit() {
    super.onInit();
    initializePreferences();
    if (box.read(kUserData) != null) {
      userdata = User.fromJson(box.read(kUserData));
    }
    connectionChecker.onStatusChange.listen((status) {
      if (status == InternetConnectionStatus.connected) {
        print('Connected to the internet');
        isConnected.value = true;
      } else {
        print('No internet connection');
        isConnected.value = false;
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    connectionChecker.dispose();
  }

  Future<void> initializePreferences() async {
    getThemeInformation();
  }

  void getThemeInformation() {
    if (box.read(kTheme) == null) {
      print('First time writing theme to storage');
      box.write(kTheme, kLight);
      isDarkMode.value = false;
    } else {
      print('Set theme from storage');
      switch (box.read(kTheme)) {
        case kDark:
          theme.value = ThemeData.dark();
          isDarkMode.value = true;
          break;
        case kLight:
          theme.value = ThemeData.light();
          isDarkMode.value = false;
          break;
        default:
          theme.value = ThemeData.light();
          isDarkMode.value = false;
      }
    }
    print('Current theme: ${box.read(kTheme)}');
  }

  void switchTheme() {
    if (box.read(kTheme) == kLight) {
      box.write(kTheme, kDark);
      theme.value = ThemeData.dark();
      isDarkMode.value = true;
    } else {
      box.write(kTheme, kLight);
      theme.value = ThemeData.light();
      isDarkMode.value = false;
    }
  }

  ThemeData getThemeByRole(String role) {
    var selectedColor = Colors.lightBlueAccent;
    switch (role) {
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
      colorScheme: ColorScheme.fromSeed(
        seedColor: selectedColor,
        brightness: Brightness.light,
      ),
    );
  }
}
