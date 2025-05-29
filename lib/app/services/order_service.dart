import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/models/order.dart';
import 'package:project428app/app/widgets/confirmation_dialog.dart';

import '../data/order_provider.dart';

class OrderService extends GetxController {
  OrderProvider OrderP = OrderProvider();
  RxList<Order> orders = <Order>[].obs;
  Rx<Order?> currentOrder = Rx<Order?>(null);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 5)).then((_) async {
      getOrders();
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void getOrders() {
    OrderP.getOrders().then((response) {
      if (response.status.hasError) {
        Get.snackbar('Error', 'Failed to fetch orders');
      } else {
        orders.value =
            (response.body as List)
                .map((e) => Order.fromJson(e as Map<String, dynamic>))
                .toList();
        orders.value = orders.reversed.toList();
      }
    });
  }

  Future<void> deleteOrder(String code, String name) async {
    ConfirmationDialog('Konfirmasi', 'Yakin menghapus \n$name ?', () async {
      await OrderP.deleteOrderById(code).then((res) {
        if (res.statusCode == 200) {
          getOrders();
          Get.back();
          Get.toNamed('/stok');
        } else {
          Get.back();
          Get.snackbar('Gagal Menghapus $name', '${res.body['message']}');
        }
      });
    });
  }
}
