import 'package:get/get.dart';

import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../data/providers/menu_category_provider.dart';
import '../../../../data/repositories/menu_category_repository.dart';
import '../controllers/select_menu_category_controller.dart';

class SelectMenuCategoryBinding extends Bindings {
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
    Get.lazyPut<SelectMenuCategoryController>(
      () => SelectMenuCategoryController(
        data: Get.find<MenuCategoryDataController>(),
      ),
    );
  }
}
