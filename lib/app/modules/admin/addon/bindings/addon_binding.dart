import 'package:abg_pos_app/app/controllers/addon_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/addon_provider.dart';
import 'package:abg_pos_app/app/data/repositories/addon_repository.dart';
import 'package:get/get.dart';

import 'package:abg_pos_app/app/modules/admin/addon/controllers/addon_detail_controller.dart';
import 'package:abg_pos_app/app/modules/admin/addon/controllers/addon_input_controller.dart';

import '../../../../controllers/ingredient_data_controller.dart';
import '../controllers/addon_list_controller.dart';

class AddonBinding extends Bindings {
  @override
  void dependencies() {
    // addons data
    Get.lazyPut<AddonProvider>(() => AddonProvider());
    Get.lazyPut<AddonRepository>(
      () => AddonRepository(provider: Get.find<AddonProvider>()),
    );
    Get.lazyPut<AddonDataController>(
      () => AddonDataController(repository: Get.find<AddonRepository>()),
    );

    // addon pages controller
    Get.lazyPut<AddonDetailController>(
      () => AddonDetailController(
        data: Get.find<AddonDataController>(),
        ingredientData: Get.find<IngredientDataController>(),
      ),
    );
    Get.lazyPut<AddonInputController>(
      () => AddonInputController(data: Get.find<AddonDataController>()),
    );
    Get.lazyPut<AddonListController>(
      () => AddonListController(data: Get.find<AddonDataController>()),
    );
  }
}
