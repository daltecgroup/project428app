import 'package:abg_pos_app/app/controllers/menu_category_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/menu_category_provider.dart';
import 'package:abg_pos_app/app/data/repositories/menu_category_repository.dart';
import 'package:abg_pos_app/app/modules/admin/menu_category/controllers/menu_category_input_controller.dart';
import 'package:get/get.dart';

import '../controllers/menu_category_list_controller.dart';

class MenuCategoryBinding extends Bindings {
  @override
  void dependencies() {
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

    // page controller
    Get.lazyPut<MenuCategoryListController>(
      () => MenuCategoryListController(
        data: Get.find<MenuCategoryDataController>(),
      ),
    );
    Get.lazyPut<MenuCategoryInputController>(
      () => MenuCategoryInputController(
        data: Get.find<MenuCategoryDataController>(),
      ),
    );
  }
}
