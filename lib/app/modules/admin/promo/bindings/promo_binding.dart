import 'package:abg_pos_app/app/controllers/promo_setting_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/promo_setting_provider.dart';
import 'package:abg_pos_app/app/data/repositories/promo_setting_repository.dart';
import 'package:get/get.dart';

import 'package:abg_pos_app/app/controllers/bundle_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/bundle_provider.dart';
import 'package:abg_pos_app/app/data/repositories/bundle_repository.dart';
import 'package:abg_pos_app/app/modules/admin/promo/controllers/bundle_detail_controller.dart';
import 'package:abg_pos_app/app/modules/admin/promo/controllers/bundle_input_controller.dart';
import 'package:abg_pos_app/app/modules/admin/promo/controllers/bundle_list_controller.dart';
import 'package:abg_pos_app/app/modules/admin/promo/controllers/buy_get_promo_controller.dart';
import 'package:abg_pos_app/app/modules/admin/promo/controllers/spend_get_promo_controller.dart';

import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../data/providers/menu_category_provider.dart';
import '../../../../data/repositories/menu_category_repository.dart';
import '../controllers/promo_controller.dart';

class PromoBinding extends Bindings {
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

    // page controllers
    Get.lazyPut<BundleListController>(
      () => BundleListController(data: Get.find<BundleDataController>()),
    );
    Get.lazyPut<BundleInputController>(
      () => BundleInputController(
        data: Get.find<BundleDataController>(),
        categoryData: Get.find<MenuCategoryDataController>(),
      ),
    );
    Get.lazyPut<BundleDetailController>(
      () => BundleDetailController(
        data: Get.find<BundleDataController>(),
        categoryData: Get.find<MenuCategoryDataController>(),
      ),
    );
    Get.lazyPut<PromoController>(
      () => PromoController(
        bundleData: Get.find<BundleDataController>(),
        promoData: Get.find<PromoSettingDataController>(),
      ),
    );
    Get.lazyPut<SpendGetPromoController>(
      () =>
          SpendGetPromoController(data: Get.find<PromoSettingDataController>()),
    );
    Get.lazyPut<BuyGetPromoController>(
      () => BuyGetPromoController(data: Get.find<PromoSettingDataController>()),
    );
  }
}
