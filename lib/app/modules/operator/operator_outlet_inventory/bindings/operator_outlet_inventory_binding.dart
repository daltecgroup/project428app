import 'package:get/get.dart';

import '../controllers/operator_outlet_inventory_controller.dart';

class OperatorOutletInventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OperatorOutletInventoryController>(
      () => OperatorOutletInventoryController(),
    );
  }
}
