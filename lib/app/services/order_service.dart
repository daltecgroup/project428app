import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
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

  List<Order> getFilteredList(List orderList, List status) {
    List<Order> result = <Order>[];
    if (orderList.isNotEmpty) {
      for (var order in orderList) {
        for (var e in status) {
          if (order.status == e) {
            result.add(order);
          }
        }
      }
    }
    return result;
  }

  Map<String, List<Order>> groupedOrders() {
    Map<String, List<Order>> groupedItems = {};

    if (orders.isEmpty) {
      return {};
    }

    String getDateHeader(DateTime date) {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final yesterday = DateTime(
        now.year,
        now.month,
        now.day,
      ).subtract(const Duration(days: 1));
      final itemDate = DateTime(date.year, date.month, date.day);

      if (itemDate == today) {
        return 'Hari Ini';
      } else if (itemDate == yesterday) {
        return 'Kemarin';
      } else {
        return DateFormat('EEEE, d MMM yyyy', 'id').format(date);
      }
    }

    for (var order in orders) {
      String dateHeader = getDateHeader(order.createdAt);
      if (!groupedItems.containsKey(dateHeader)) {
        groupedItems[dateHeader] = [];
      }
      groupedItems[dateHeader]!.add(order);
    }

    return groupedItems;
  }
}
