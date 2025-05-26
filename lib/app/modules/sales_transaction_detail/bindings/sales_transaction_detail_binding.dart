import 'package:get/get.dart';

import '../controllers/sales_transaction_detail_controller.dart';

class SalesTransactionDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SalesTransactionDetailController>(
      () => SalesTransactionDetailController(),
    );
  }
}
