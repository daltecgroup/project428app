import 'package:get/get.dart';

import '../controllers/stok_operator_controller.dart';

class StokOperatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StokOperatorController>(
      () => StokOperatorController(),
    );
  }
}
