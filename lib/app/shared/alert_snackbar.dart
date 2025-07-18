import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/constants/app_constants.dart';

SnackbarController unauthorizedSnackbar() {
  return Get.snackbar(
    'Akses Ditolak',
    'Anda tidak memiliki ijin untuk mengakses data pada halaman tersebut.',
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.only(
      top: AppConstants.DEFAULT_VERTICAL_MARGIN,
      left: AppConstants.DEFAULT_VERTICAL_MARGIN,
      right: AppConstants.DEFAULT_VERTICAL_MARGIN,
    ),
    backgroundColor: Colors.red,
    colorText: Colors.white,
  );
}

SnackbarController expiredSnackbar() {
  return Get.snackbar(
    'Token Kadaluarsa',
    'Lakukan login untuk kembali dapat mengakses halaman tersebut',
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.only(
      top: AppConstants.DEFAULT_VERTICAL_MARGIN,
      left: AppConstants.DEFAULT_VERTICAL_MARGIN,
      right: AppConstants.DEFAULT_VERTICAL_MARGIN,
    ),
    backgroundColor: Colors.white,
    colorText: Colors.black,
  );
}

SnackbarController successSnackbar(String content) {
  return Get.snackbar(
    'Berhasil',
    content,
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.only(
      top: AppConstants.DEFAULT_VERTICAL_MARGIN,
      left: AppConstants.DEFAULT_VERTICAL_MARGIN,
      right: AppConstants.DEFAULT_VERTICAL_MARGIN,
    ),
    backgroundColor: Colors.white,
    colorText: Colors.black,
  );
}

SnackbarController alertSnackbar(String content) {
  return Get.snackbar(
    'Peringatan',
    content,
    snackPosition: SnackPosition.TOP,
    margin: EdgeInsets.only(
      top: AppConstants.DEFAULT_VERTICAL_MARGIN,
      left: AppConstants.DEFAULT_VERTICAL_MARGIN,
      right: AppConstants.DEFAULT_VERTICAL_MARGIN,
    ),
    backgroundColor: Colors.white,
    colorText: Colors.black,
  );
}
