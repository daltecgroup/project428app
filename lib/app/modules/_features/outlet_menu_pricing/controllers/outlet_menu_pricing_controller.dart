import 'package:abg_pos_app/app/controllers/menu_category_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_data_controller.dart';
import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:get/get.dart';

import '../../../../data/models/Menu.dart';
import '../../../../data/models/MenuCategory.dart';

class OutletMenuPricingController extends GetxController {
  OutletMenuPricingController({
    required this.outletData,
    required this.menuCategoryData,
    required this.menuData,
  });
  final OutletDataController outletData;
  final MenuCategoryDataController menuCategoryData;
  final MenuDataController menuData;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> refreshData() async {
    await menuData.syncData(refresh: true);
    await menuCategoryData.syncData(refresh: true);
  }

  List<Menu> filteredMenus({bool? status}) {
    List<Menu> list = menuData.menus;
    if (status != null) {
      list = menuData.menus.where((e) => e.isActive == status).toList();
    }
    return list;
  }

  List<MenuCategory> filteredMenuCategory({bool? status}) {
    List<MenuCategory> list = menuCategoryData.categories;
    if (status != null) {
      list = menuCategoryData.categories
          .where((e) => e.isActive == status)
          .toList();
    }
    return list;
  }

  Map<String, List<Menu>> get groupMenusByCategory {
    final menus = filteredMenus();
    final categories = filteredMenuCategory(status: true);

    // Group menus by categoryId
    final grouped = <String, List<Menu>>{};
    final nonCategory = <Menu>[];

    for (var menu in menus) {
      final categoryId = menu.menuCategoryId;
      if (categories.any((c) => c.id == categoryId)) {
        grouped.putIfAbsent(categoryId, () => []).add(menu);
      } else {
        nonCategory.add(menu);
      }
    }

    // Ensure all categories are present in the map (even if empty)
    for (var category in categories) {
      grouped.putIfAbsent(category.id, () => []);
    }

    grouped['noneCategory'] = nonCategory;
    return grouped;
  }
}
