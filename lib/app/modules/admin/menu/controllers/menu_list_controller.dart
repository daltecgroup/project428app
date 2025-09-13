import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../controllers/menu_data_controller.dart';
import '../../../../data/models/Menu.dart';
import '../../../../data/models/MenuCategory.dart';

class MenuListController extends GetxController {
  MenuListController({required this.data, required this.categoryData});
  MenuDataController data;
  MenuCategoryDataController categoryData;

  final searchC = TextEditingController();
  final keyword = ''.obs;

  final String backRoute = Get.previousRoute;

  @override
  Future<void> onInit() async {
    super.onInit();
    await refreshData();
  }

  @override
  void onClose() {
    super.onClose();
    searchC.dispose();
  }

  Future<void> refreshMenus() => data.syncData(refresh: true);

  void searchKeyword() {
    keyword.value = searchC.text.toLowerCase().trim();
  }

  List<Menu> filteredMenus({String? keyword}) {
    return data.menus
        .where(
          (e) =>
              // e.isActive == status &&
              (keyword != null && e.name.contains(keyword)),
        )
        .toList();
  }

  List<MenuCategory> filteredMenuCategory({bool? status}) {
    List<MenuCategory> list = categoryData.categories;
    if (status != null) {
      list = categoryData.categories
          .where((e) => e.isActive == status)
          .toList();
    }
    return list;
  }

  Map<String, List<Menu>> groupMenusByCategory({String? keyword}) {
    final menus = filteredMenus(keyword: keyword);
    final categories = filteredMenuCategory(status: true);

    // Group menus by categoryId
    final grouped = <String, List<Menu>>{};
    final nonCategory = <Menu>[];

    print(menus.length);

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

  Future<void> refreshData() async {
    await data.syncData(refresh: true);
    await categoryData.syncData(refresh: true);
  }
}
