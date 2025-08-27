import 'package:get/get.dart';

import '../../controllers/outlet_inventory_data_controller.dart';

Future<void> refreshOutletInventoryData() async {
  if (Get.isRegistered<OutletInventoryDataController>()) {
    final outletInventory = Get.find<OutletInventoryDataController>();
    await outletInventory.syncData(refresh: true);
  }
}
