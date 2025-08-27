import 'package:abg_pos_app/app/controllers/ingredient_data_controller.dart';
import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/controllers/outlet_inventory_transaction_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/outlet_inventory_transaction_provider.dart';
import 'package:abg_pos_app/app/data/repositories/outlet_inventory_transaction_repository.dart';
import 'package:get/get.dart';

import '../../../../controllers/outlet_inventory_data_controller.dart';
import '../../../../data/providers/ingredient_provider.dart';
import '../../../../data/providers/outlet_inventory_provider.dart';
import '../../../../data/providers/outlet_provider.dart';
import '../../../../data/repositories/ingredient_repository.dart';
import '../../../../data/repositories/outlet_inventory_repository.dart';
import '../../../../data/repositories/outlet_repository.dart';
import '../controllers/outlet_inventory_adjustment_controller.dart';

class OutletInventoryAdjustmentBinding extends Bindings {
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

    // ingredient data
    Get.lazyPut<IngredientProvider>(() => IngredientProvider());
    Get.lazyPut<IngredientRepository>(
      () => IngredientRepository(provider: Get.find<IngredientProvider>()),
    );
    Get.lazyPut<IngredientDataController>(
      () => IngredientDataController(
        repository: Get.find<IngredientRepository>(),
      ),
    );

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

    Get.lazyPut<OutletInventoryAdjustmentController>(
      () => OutletInventoryAdjustmentController(
        outletData: Get.find<OutletDataController>(),
        ingredientData: Get.find<IngredientDataController>(),
        transactionData: Get.find<OutletInventoryTransactionDataController>(),
        data: Get.find<OutletInventoryDataController>(),
      ),
    );
  }
}
