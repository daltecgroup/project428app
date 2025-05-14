import 'package:get/get.dart';

import '../controllers/transaksi_operator_controller.dart';

class TransaksiOperatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransaksiOperatorController>(
      () => TransaksiOperatorController(),
    );
  }
}
