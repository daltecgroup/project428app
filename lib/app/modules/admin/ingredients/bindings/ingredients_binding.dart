import 'package:get/get.dart';

import 'package:abg_pos_app/app/controllers/ingredient_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/ingredient_provider.dart';
import 'package:abg_pos_app/app/data/repositories/ingredient_repository.dart';
import 'package:abg_pos_app/app/modules/admin/ingredients/controllers/ingredient_detail_controller.dart';
import 'package:abg_pos_app/app/modules/admin/ingredients/controllers/ingredient_input_controller.dart';

import '../controllers/ingredient_list_controller.dart';

class IngredientsBinding extends Bindings {
  @override
  void dependencies() {
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

    // page controllers
    Get.lazyPut<IngredientListController>(
      () =>
          IngredientListController(data: Get.find<IngredientDataController>()),
    );
    Get.lazyPut<IngredientDetailController>(
      () => IngredientDetailController(
        data: Get.find<IngredientDataController>(),
      ),
    );
    Get.lazyPut<IngredientInputController>(
      () =>
          IngredientInputController(data: Get.find<IngredientDataController>()),
    );
  }
}
