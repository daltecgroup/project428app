import 'package:abg_pos_app/app/controllers/addon_data_controller.dart';
import 'package:abg_pos_app/app/controllers/bundle_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_data_controller.dart';
import 'package:abg_pos_app/app/controllers/promo_setting_data_controller.dart';
import 'package:abg_pos_app/app/utils/services/sale_service.dart';
import 'package:get/get.dart';

import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../data/providers/addon_provider.dart';
import '../../../../data/providers/bundle_provider.dart';
import '../../../../data/providers/menu_category_provider.dart';
import '../../../../data/providers/menu_provider.dart';
import '../../../../data/providers/promo_setting_provider.dart';
import '../../../../data/repositories/addon_repository.dart';
import '../../../../data/repositories/bundle_repository.dart';
import '../../../../data/repositories/menu_category_repository.dart';
import '../../../../data/repositories/menu_repository.dart';
import '../../../../data/repositories/promo_setting_repository.dart';
import '../controllers/sale_input_controller.dart';

class SaleInputBinding extends Bindings {
  @override
  void dependencies() {
    // bundle data
    Get.lazyPut<BundleProvider>(() => BundleProvider());
    Get.lazyPut<BundleRepository>(
      () => BundleRepository(provider: Get.find<BundleProvider>()),
    );
    Get.lazyPut<BundleDataController>(
      () => BundleDataController(repository: Get.find<BundleRepository>()),
    );

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

    // menu data
    Get.lazyPut<MenuProvider>(() => MenuProvider());
    Get.lazyPut<MenuRepository>(
      () => MenuRepository(provider: Get.find<MenuProvider>()),
    );
    Get.lazyPut<MenuDataController>(
      () => MenuDataController(repository: Get.find<MenuRepository>()),
    );

    // addons data
    Get.lazyPut<AddonProvider>(() => AddonProvider());
    Get.lazyPut<AddonRepository>(
      () => AddonRepository(provider: Get.find<AddonProvider>()),
    );
    Get.lazyPut<AddonDataController>(
      () => AddonDataController(repository: Get.find<AddonRepository>()),
    );

    // promo setting data
    Get.lazyPut<PromoSettingProvider>(() => PromoSettingProvider());
    Get.lazyPut<PromoSettingRepository>(
      () => PromoSettingRepository(provider: Get.find<PromoSettingProvider>()),
    );
    Get.lazyPut<PromoSettingDataController>(
      () => PromoSettingDataController(
        repository: Get.find<PromoSettingRepository>(),
      ),
    );

    // ensure SaleService is registered
    SaleService service = Get.isRegistered<SaleService>()
        ? Get.find<SaleService>()
        : Get.put(SaleService());

    Get.lazyPut(
      () => SaleInputController(
        bundleData: Get.find<BundleDataController>(),
        menuData: Get.find<MenuDataController>(),
        menuCategoryData: Get.find<MenuCategoryDataController>(),
        addonData: Get.find<AddonDataController>(),
        promoSettingData: Get.find<PromoSettingDataController>(),
        service: service,
      ),
    );
  }
}
