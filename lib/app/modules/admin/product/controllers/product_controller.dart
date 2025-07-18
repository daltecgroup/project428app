import 'package:abg_pos_app/app/controllers/addon_data_controller.dart';
import 'package:abg_pos_app/app/controllers/ingredient_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_category_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_data_controller.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  ProductController({
    required this.ingredientData,
    required this.menuCategoryData,
    required this.addonData,
    required this.menuData,
  });
  IngredientDataController ingredientData;
  MenuCategoryDataController menuCategoryData;
  AddonDataController addonData;
  MenuDataController menuData;

  int get ingredientCount => ingredientData.ingredients.length;
  int get menuCategoryCount => menuCategoryData.categories.length;
  int get addonCount => addonData.addons.length;
  int get menuCount => menuData.menus.length;

  Future<void> refreshAll() async {
    await ingredientData.syncData();
    await menuCategoryData.syncData(refresh: true);
    await addonData.syncData(refresh: true);
    await menuData.syncData(refresh: true);
  }

  void stopSync() {
    ingredientData.stopAutoSync();
    menuCategoryData.stopAutoSync();
    addonData.stopAutoSync();
    menuData.stopAutoSync();
  }
}
