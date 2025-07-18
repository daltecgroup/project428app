import 'package:get/get.dart';
import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../controllers/menu_data_controller.dart';
import '../../../../data/models/Menu.dart';

class SelectMenuController extends GetxController {
  SelectMenuController({required this.categoryData, required this.menuData});
  final MenuCategoryDataController categoryData;
  final MenuDataController menuData;

  RxBool showOnline = false.obs;

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

  String? get getArgumentCategoryId {
    final categoryId = Get.arguments == null
        ? null
        : Get.arguments['categoryId'];
    if (categoryId == null || categoryId is! String) return null;
    if (categoryData.getCategory(categoryId) == null) return null;
    return categoryId;
  }

  List<Menu> getMenus() {
    final menuList = menuData.menus.where((menu) {
      if (showOnline.value) return menu.name.contains('online');
      return true;
    }).toList();
    if (getArgumentCategoryId == null) return menuList;
    if (getArgumentCategoryId != null) {
      return menuList
          .where((menu) => menu.menuCategoryId == getArgumentCategoryId)
          .toList();
    }
    return menuList;
  }
}
