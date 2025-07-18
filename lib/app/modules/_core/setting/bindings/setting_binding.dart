import 'package:abg_pos_app/app/modules/admin/product/controllers/product_controller.dart';
import 'package:get/get.dart';

import '../../../../controllers/addon_data_controller.dart';
import '../../../../controllers/ingredient_data_controller.dart';
import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../controllers/menu_data_controller.dart';
import '../../../../data/providers/addon_provider.dart';
import '../../../../data/providers/ingredient_provider.dart';
import '../../../../data/providers/menu_category_provider.dart';
import '../../../../data/providers/menu_provider.dart';
import '../../../../data/repositories/addon_repository.dart';
import '../../../../data/repositories/ingredient_repository.dart';
import '../../../../data/repositories/menu_category_repository.dart';
import '../../../../data/repositories/menu_repository.dart';
import '../controllers/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    // menu category
    Get.lazyPut<MenuCategoryProvider>(() => MenuCategoryProvider());
    Get.lazyPut<MenuCategoryRepository>(
      () => MenuCategoryRepository(provider: Get.find<MenuCategoryProvider>()),
    );
    Get.lazyPut<MenuCategoryDataController>(
      () => MenuCategoryDataController(
        repository: Get.find<MenuCategoryRepository>(),
      ),
    );

    // ingredient
    Get.lazyPut<IngredientProvider>(() => IngredientProvider());
    Get.lazyPut<IngredientRepository>(
      () => IngredientRepository(provider: Get.find<IngredientProvider>()),
    );
    Get.lazyPut<IngredientDataController>(
      () => IngredientDataController(
        repository: Get.find<IngredientRepository>(),
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

    // addons
    Get.lazyPut<AddonProvider>(() => AddonProvider());
    Get.lazyPut<AddonRepository>(
      () => AddonRepository(provider: Get.find<AddonProvider>()),
    );
    Get.lazyPut<AddonDataController>(
      () => AddonDataController(repository: Get.find<AddonRepository>()),
    );

    if (!Get.isRegistered<ProductController>()) {
      Get.put(
        ProductController(
          ingredientData: Get.find<IngredientDataController>(),
          menuCategoryData: Get.find<MenuCategoryDataController>(),
          addonData: Get.find<AddonDataController>(),
          menuData: Get.find<MenuDataController>(),
        ),
      );
    }
    Get.put(
      SettingController(productController: Get.find<ProductController>()),
    );
  }
}
