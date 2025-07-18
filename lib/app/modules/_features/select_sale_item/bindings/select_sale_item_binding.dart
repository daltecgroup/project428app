import 'package:abg_pos_app/app/controllers/bundle_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/bundle_provider.dart';
import 'package:abg_pos_app/app/data/repositories/bundle_repository.dart';
import 'package:abg_pos_app/app/utils/services/sale_service.dart';
import 'package:get/get.dart';

import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../controllers/menu_data_controller.dart';
import '../../../../controllers/promo_setting_data_controller.dart';
import '../../../../data/providers/menu_category_provider.dart';
import '../../../../data/providers/menu_provider.dart';
import '../../../../data/providers/promo_setting_provider.dart';
import '../../../../data/repositories/menu_category_repository.dart';
import '../../../../data/repositories/menu_repository.dart';
import '../../../../data/repositories/promo_setting_repository.dart';
import '../controllers/select_sale_item_controller.dart';

class SelectSaleItemBinding extends Bindings {
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

    // menu data
    Get.lazyPut<MenuProvider>(() => MenuProvider());
    Get.lazyPut<MenuRepository>(
      () => MenuRepository(provider: Get.find<MenuProvider>()),
    );
    Get.lazyPut<MenuDataController>(
      () => MenuDataController(repository: Get.find<MenuRepository>()),
    );

    // bundle data
    Get.lazyPut<BundleProvider>(() => BundleProvider());
    Get.lazyPut<BundleRepository>(
      () => BundleRepository(provider: Get.find<BundleProvider>()),
    );
    Get.lazyPut<BundleDataController>(
      () => BundleDataController(repository: Get.find<BundleRepository>()),
    );

    // ensure SaleService is registered
    SaleService service = Get.isRegistered<SaleService>()
        ? Get.find<SaleService>()
        : Get.put(SaleService());

    Get.lazyPut<SelectSaleItemController>(
      () => SelectSaleItemController(
        categoryData: Get.find<MenuCategoryDataController>(),
        menuData: Get.find<MenuDataController>(),
        bundleData: Get.find<BundleDataController>(),
        service: service,
      ),
    );
  }
}
