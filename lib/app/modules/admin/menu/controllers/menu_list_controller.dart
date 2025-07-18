import 'package:get/get.dart';
import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../controllers/menu_data_controller.dart';
import '../../../../data/models/Menu.dart';
import '../../../../data/models/MenuCategory.dart';
import '../../../../utils/helpers/get_storage_helper.dart';

class MenuListController extends GetxController {
  MenuListController({required this.data, required this.categoryData});
  MenuDataController data;
  MenuCategoryDataController categoryData;

  late BoxHelper box;
  final String backRoute = Get.previousRoute;

  @override
  Future<void> onInit() async {
    super.onInit();
    box = BoxHelper();
    await refreshData();
  }

  Future<void> refreshMenus() => data.syncData(refresh: true);

  List<Menu> filteredMenus({bool? status}) {
    List<Menu> list = data.menus;
    if (status != null) {
      list = data.menus.where((e) => e.isActive == status).toList();
    }
    return list;
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

  Future<void> refreshData() async {
    await data.syncData(refresh: true);
    await categoryData.syncData(refresh: true);
  }
}
