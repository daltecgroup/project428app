import 'package:abg_pos_app/app/controllers/addon_data_controller.dart';
import 'package:abg_pos_app/app/controllers/bundle_data_controller.dart';
import 'package:abg_pos_app/app/controllers/ingredient_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_category_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_data_controller.dart';
import 'package:abg_pos_app/app/controllers/order_data_controller.dart';
import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/controllers/promo_setting_data_controller.dart';
import 'package:abg_pos_app/app/controllers/sale_data_controller.dart';
import 'package:abg_pos_app/app/controllers/user_data_controller.dart';
import 'package:get/get.dart';

void stopAllAutoSync() {
  if (Get.isRegistered<UserDataController>())
    Get.find<UserDataController>().stopAutoSync();

  if (Get.isRegistered<IngredientDataController>())
    Get.find<IngredientDataController>().stopAutoSync();

  if (Get.isRegistered<MenuCategoryDataController>())
    Get.find<MenuCategoryDataController>().stopAutoSync();

  if (Get.isRegistered<MenuDataController>())
    Get.find<MenuDataController>().stopAutoSync();

  if (Get.isRegistered<BundleDataController>())
    Get.find<BundleDataController>().stopAutoSync();

  if (Get.isRegistered<AddonDataController>())
    Get.find<AddonDataController>().stopAutoSync();

  if (Get.isRegistered<OrderDataController>())
    Get.find<OrderDataController>().stopAutoSync();

  if (Get.isRegistered<OutletDataController>())
    Get.find<OutletDataController>().stopAutoSync();

  if (Get.isRegistered<PromoSettingDataController>())
    Get.find<PromoSettingDataController>().stopAutoSync();

  if (Get.isRegistered<SaleDataController>())
    Get.find<SaleDataController>().stopAutoSync();
}
