import 'package:get/get.dart';

import '../controllers/outlet_inventory_controller.dart';

class OutletInventoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutletInventoryController>(
      () => OutletInventoryController(),
    );
  }
}
