import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:get/get.dart';

import '../../../../controllers/outlet_inventory_data_controller.dart';
import '../../../../data/providers/outlet_inventory_provider.dart';
import '../../../../data/providers/outlet_provider.dart';
import '../../../../data/repositories/outlet_inventory_repository.dart';
import '../../../../data/repositories/outlet_repository.dart';
import '../../outlet_inventory/controllers/outlet_inventory_controller.dart';
import '../controllers/outlet_inventory_list_controller.dart';

class OutletInventoryListBinding extends Bindings {
  @override
  void dependencies() {
    // outlet data
    Get.lazyPut<OutletProvider>(() => OutletProvider());
    Get.lazyPut<OutletRepository>(
      () => OutletRepository(provider: Get.find<OutletProvider>()),
    );
    Get.lazyPut<OutletDataController>(
      () => OutletDataController(repository: Get.find<OutletRepository>()),
    );

    // outlet inventory data
    Get.lazyPut<OutletInventoryProvider>(() => OutletInventoryProvider());
    Get.lazyPut<OutletInventoryRepository>(
      () => OutletInventoryRepository(provider: Get.find<OutletInventoryProvider>()),
    );
    Get.lazyPut<OutletInventoryDataController>(
      () => OutletInventoryDataController(repository: Get.find<OutletInventoryRepository>()),
    );

    Get.lazyPut<OutletInventoryController>(
      () => OutletInventoryController(data: Get.find<OutletInventoryDataController>()),
    );

    Get.lazyPut<OutletInventoryListController>(
      () => OutletInventoryListController(
        outletData: Get.find<OutletDataController>(),
        data: Get.find<OutletInventoryDataController>(),
        outletInventoryController: Get.find<OutletInventoryController>()
      ),
    );
  }
}
