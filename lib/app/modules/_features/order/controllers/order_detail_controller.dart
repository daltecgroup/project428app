import 'dart:convert';

import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/controllers/user_data_controller.dart';
import 'package:abg_pos_app/app/data/models/OrderItem.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../controllers/order_data_controller.dart';
import '../../../../shared/custom_alert.dart';
import '../../../../utils/helpers/number_helper.dart';
import '../../../../utils/helpers/text_helper.dart';

class OrderDetailController extends GetxController {
  OrderDetailController({
    required this.data,
    required this.outletData,
    required this.userData,
  });
  final OrderDataController data;
  final OutletDataController outletData;
  final UserDataController userData;
  final String backRoute = Get.previousRoute;

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

  Future<void> refreshData() async => await data.syncData(refresh: true);

  void acceptOrderItem(OrderItem item) {
    final updateData = {};
    updateData['items'] = [
      {'ingredientId': item.ingredientId, 'isAccepted': true},
    ];
    customConfirmationDialog(
      'Apakah yakin jumlah \'${normalizeName(item.name)}\' yang diterima sebesar ${inLocalNumber(item.qty / 1000)} Kg ?',
      () async {
        Get.back();
        Future.delayed(Durations.short1);
        await data.updateOrder(
          id: data.selectedOrder.value!.id,
          data: json.encode(updateData),
        );
      },
    );
  }

  void unacceptOrderItem(OrderItem item) {
    final updateData = {};
    updateData['items'] = [
      {'ingredientId': item.ingredientId, 'isAccepted': false},
    ];
    customConfirmationDialog(
      'Batalkan status terima di barang \'${normalizeName(item.name)}\'?',
      () async {
        Get.back();
        Future.delayed(Durations.short1);
        await data.updateOrder(
          id: data.selectedOrder.value!.id,
          data: json.encode(updateData),
        );
      },
    );
  }

  void addEvidenceDialog(OrderItem item) {
    customConfirmationDialog(
      'Unggah bukti penerimaan \'${normalizeName(item.name)}\' sekarang?',
      () {
        item.changeStatus(false);
        data.selectedOrder.refresh();
        Get.back();
      },
      confirmText: 'Ya',
      cancelText: 'Nanti Saja',
    );
  }

  Future<void> updateOrder() async {
    String status = await changeOrderStatusSelectionDialog();
    if (status != '') {
      await data.updateOrder(
        id: data.selectedOrder.value!.id,
        data: json.encode({'status': status}),
      );
    }
  }
}
