import 'dart:io';

import 'package:abg_pos_app/app/modules/admin/product/controllers/product_controller.dart';
import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:abg_pos_app/app/utils/helpers/logger_helper.dart';
import 'package:get/get.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/file_helper.dart';

class SettingController extends GetxController {
  SettingController({required this.productController});
  late File userDataFile;

  ProductController productController;

  RxBool syncStatus = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    userDataFile = await getLocalFile(AppConstants.FILENAME_USER_DATA);
  }

  Future<void> deleteLocalFiles() async {
    customDeleteAlertDialog('Yakin menghapus data lokal?', () async {
      if (await userDataFile.exists()) {
        await userDataFile.delete().then((value) {
          LoggerHelper.logWarning('User Data file deleted.');
        });
      }
      Get.back();
      customAlertDialog('Data Lokal berhasil dihapus');
    });
  }

  void stopProductSync() {
    productController.stopSync();
  }

  void startProductSync() {
    // productController.stopSync();
  }
}
