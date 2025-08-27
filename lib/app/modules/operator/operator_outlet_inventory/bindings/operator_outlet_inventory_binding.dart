import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/outlet_provider.dart';
import 'package:abg_pos_app/app/data/repositories/outlet_repository.dart';
import 'package:get/get.dart';

import '../../../../controllers/outlet_inventory_data_controller.dart';
import '../../../../data/providers/outlet_inventory_provider.dart';
import '../../../../data/repositories/outlet_inventory_repository.dart';
import '../../../_features/outlet_inventory/controllers/outlet_inventory_controller.dart';
import '../controllers/operator_outlet_inventory_controller.dart';

class OperatorOutletInventoryBinding extends Bindings {
  @override
  void dependencies() {
    // outlet inventory data
    Get.lazyPut<OutletInventoryProvider>(() => OutletInventoryProvider());
    Get.lazyPut<OutletInventoryRepository>(
      () => OutletInventoryRepository(
        provider: Get.find<OutletInventoryProvider>(),
      ),
    );
    Get.lazyPut<OutletInventoryDataController>(
      () => OutletInventoryDataController(
        repository: Get.find<OutletInventoryRepository>(),
      ),
    );

    // outlet inventory data
    Get.lazyPut<OutletProvider>(() => OutletProvider());
    Get.lazyPut<OutletRepository>(
      () => OutletRepository(provider: Get.find<OutletProvider>()),
    );
    Get.lazyPut<OutletDataController>(
      () => OutletDataController(repository: Get.find<OutletRepository>()),
    );

    Get.lazyPut<OutletInventoryController>(
      () => OutletInventoryController(
        data: Get.find<OutletInventoryDataController>(),
      ),
    );
    Get.lazyPut<OperatorOutletInventoryController>(
      () => OperatorOutletInventoryController(
        outletData: Get.find<OutletDataController>(),
      ),
    );
  }
}
