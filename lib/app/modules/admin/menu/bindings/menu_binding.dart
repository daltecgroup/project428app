import 'package:abg_pos_app/app/controllers/ingredient_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/menu_provider.dart';
import 'package:abg_pos_app/app/data/repositories/menu_repository.dart';
import 'package:get/get.dart';

import 'package:abg_pos_app/app/modules/admin/menu/controllers/menu_detail_controller.dart';
import 'package:abg_pos_app/app/modules/admin/menu/controllers/menu_input_controller.dart';

import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../data/providers/ingredient_provider.dart';
import '../../../../data/providers/menu_category_provider.dart';
import '../../../../data/repositories/ingredient_repository.dart';
import '../../../../data/repositories/menu_category_repository.dart';
import '../controllers/menu_list_controller.dart';

class MenuBinding extends Bindings {
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

    // menu category data
    Get.lazyPut<MenuCategoryProvider>(() => MenuCategoryProvider());
    Get.lazyPut<MenuCategoryRepository>(
      () => MenuCategoryRepository(provider: Get.find<MenuCategoryProvider>()),
    );
    Get.lazyPut<MenuCategoryDataController>(
      () => MenuCategoryDataController(
        repository: Get.find<MenuCategoryRepository>(),
      ),
    );

    // menu data
    Get.lazyPut<MenuProvider>(() => MenuProvider());
    Get.lazyPut<MenuRepository>(
      () => MenuRepository(provider: Get.find<MenuProvider>()),
    );
    Get.lazyPut<MenuDataController>(
      () => MenuDataController(repository: Get.find<MenuRepository>()),
    );

    // page controllers
    Get.lazyPut<MenuDetailController>(
      () => MenuDetailController(
        data: Get.find<MenuDataController>(),
        ingredientData: Get.find<IngredientDataController>(),
        categoryData: Get.find<MenuCategoryDataController>(),
      ),
    );
    Get.lazyPut<MenuInputController>(
      () => MenuInputController(
        data: Get.find<MenuDataController>(),
        ingredientData: Get.find<IngredientDataController>(),
        categoryData: Get.find<MenuCategoryDataController>(),
      ),
    );
    Get.lazyPut<MenuListController>(
      () => MenuListController(
        data: Get.find<MenuDataController>(),
        categoryData: Get.find<MenuCategoryDataController>(),
      ),
    );
  }
}
