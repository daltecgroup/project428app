import 'package:get/get.dart';

import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../controllers/menu_data_controller.dart';
import '../../../../controllers/outlet_data_controller.dart';
import '../../../../data/providers/menu_category_provider.dart';
import '../../../../data/providers/menu_provider.dart';
import '../../../../data/providers/outlet_provider.dart';
import '../../../../data/repositories/menu_category_repository.dart';
import '../../../../data/repositories/menu_repository.dart';
import '../../../../data/repositories/outlet_repository.dart';
import '../controllers/outlet_menu_pricing_controller.dart';

class OutletMenuPricingBinding extends Bindings {
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

    Get.lazyPut<OutletMenuPricingController>(
      () => OutletMenuPricingController(
        outletData: Get.find<OutletDataController>(),
        menuCategoryData: Get.find<MenuCategoryDataController>(),
        menuData: Get.find<MenuDataController>(),
      ),
    );
  }
}
