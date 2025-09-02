import 'package:get/get.dart';

import '../controllers/ingredient_purchase_input_controller.dart';

class IngredientPurchaseInputBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IngredientPurchaseInputController>(
      () => IngredientPurchaseInputController(),
    );
  }
}
