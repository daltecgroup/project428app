import 'package:get/get.dart';
import 'package:project428app/app/models/order.dart';

import '../data/order_provider.dart';

class OrderService extends GetxController {
  OrderProvider OrderP = OrderProvider();
  RxList<Order> orders = <Order>[].obs;

  @override
  void onInit() {
    super.onInit();
    getOrders();
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
}
