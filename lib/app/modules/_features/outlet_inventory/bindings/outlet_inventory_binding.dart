import 'package:get/get.dart';
import '../../../../controllers/outlet_inventory_data_controller.dart';
import '../../../../data/providers/outlet_inventory_provider.dart';
import '../../../../data/repositories/outlet_inventory_repository.dart';
import '../controllers/outlet_inventory_controller.dart';

class OutletInventoryBinding extends Bindings {
  @override
  void dependencies() {
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
  }
}
