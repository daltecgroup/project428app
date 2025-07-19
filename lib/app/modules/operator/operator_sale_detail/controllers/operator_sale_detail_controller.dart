import 'dart:convert';

import 'package:abg_pos_app/app/controllers/sale_data_controller.dart';
import 'package:abg_pos_app/app/controllers/user_data_controller.dart';
import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class OperatorSaleDetailController extends GetxController {
  OperatorSaleDetailController({required this.data, required this.userData});
  final SaleDataController data;
  final UserDataController userData;

  RxBool showPrintHistory = true.obs;

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

  Future<void> printInvoice(String id) async {
    if (data.selectedSale.value != null) {
      await data.updateSale(
        id: id,
        data: json.encode({"addInvoicePrintHistory": true}),
      );
      data.sales.refresh();
      data.selectedSale.refresh();
    } else {
      customAlertDialog('Data Penjualan tidak ditemukan');
    }
  }

  void deleteRequest({required String saleCode, required String saleId}) {
    customDeleteAlertDialog('Yakin meminta penjualan $saleCode dihapus?', () {
      Get.back();
      customAlertDialogWithTitle(
        title: 'Permintaan Dikirim',
        content: Text('Permintaan telah dikirm ke admin'),
      );
    });
  }

  String getUserName(String id) {
    final user = userData.getUser(id);

    if (user == null) return 'admin';
    return user.name;
  }
}
