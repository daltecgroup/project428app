import 'package:get/get.dart';

import '../../../../controllers/outlet_inventory_transaction_data_controller.dart';
import '../../../../data/providers/outlet_inventory_transaction_provider.dart';
import '../../../../data/repositories/outlet_inventory_transaction_repository.dart';
import '../controllers/outlet_inventory_history_controller.dart';

class OutletInventoryHistoryBinding extends Bindings {
  @override
  void dependencies() {
    // outlet inventory transaction data
    Get.lazyPut<OutletInventoryTransactionProvider>(
      () => OutletInventoryTransactionProvider(),
    );
    Get.lazyPut<OutletInventoryTransactionRepository>(
      () => OutletInventoryTransactionRepository(
        provider: Get.find<OutletInventoryTransactionProvider>(),
      ),
    );
    Get.lazyPut<OutletInventoryTransactionDataController>(
      () => OutletInventoryTransactionDataController(
        repository: Get.find<OutletInventoryTransactionRepository>(),
      ),
    );

    Get.lazyPut<OutletInventoryHistoryController>(
      () => OutletInventoryHistoryController(
        data: Get.find<OutletInventoryTransactionDataController>(),
      ),
    );
  }
}
