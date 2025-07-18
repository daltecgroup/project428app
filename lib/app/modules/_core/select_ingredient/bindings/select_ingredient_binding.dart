import 'package:get/get.dart';

import '../../../../controllers/ingredient_data_controller.dart';
import '../../../../data/providers/ingredient_provider.dart';
import '../../../../data/repositories/ingredient_repository.dart';
import '../controllers/select_ingredient_controller.dart';

class SelectIngredientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IngredientProvider>(() => IngredientProvider());
    Get.lazyPut<IngredientRepository>(
      () => IngredientRepository(provider: Get.find<IngredientProvider>()),
    );
    Get.lazyPut<IngredientDataController>(
      () => IngredientDataController(
        repository: Get.find<IngredientRepository>(),
      ),
    );
    Get.lazyPut<SelectIngredientController>(
      () => SelectIngredientController(
        data: Get.find<IngredientDataController>(),
      ),
    );
  }
}
