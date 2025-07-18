import 'package:get/get.dart';

import '../../../../shared/pages/order_list/controllers/order_list_controller.dart';

class OperatorOrderListController extends GetxController {
  OperatorOrderListController({required this.listController});
  final OrderListController listController;
  final count = 0.obs;
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

  void increment() => count.value++;
}
