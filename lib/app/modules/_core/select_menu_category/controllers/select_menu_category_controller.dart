import 'package:abg_pos_app/app/controllers/menu_category_data_controller.dart';
import 'package:abg_pos_app/app/data/models/BundleCategory.dart';
import 'package:abg_pos_app/app/data/models/MenuCategory.dart';
import 'package:get/get.dart';

class SelectMenuCategoryController extends GetxController {
  SelectMenuCategoryController({required this.data});
  final MenuCategoryDataController data;

  RxList<BundleCategory> bundleCategoryList = <BundleCategory>[].obs;
  RxList<BundleCategory> initialList = <BundleCategory>[].obs;

  @override
  void onInit() {
    super.onInit();
    initList();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void initList() {
    if (Get.arguments != null && Get.arguments is List<BundleCategory>) {
      bundleCategoryList.assignAll(Get.arguments);
      initialList.assignAll(Get.arguments);
    }
  }

  void addCategoryToList(MenuCategory category) {
    bundleCategoryList.add(BundleCategory(menuCategoryId: category.id, qty: 1));
  }

  BundleCategory? getBundleCategoryById(String categoryId) {
    if (bundleCategoryList.isEmpty) return null;
    return bundleCategoryList.firstWhereOrNull(
      (e) => e.menuCategoryId == categoryId,
    );
  }

  void removeBundleCategory(String categoryId) {
    if (bundleCategoryList.isNotEmpty) {
      bundleCategoryList.removeWhere((e) => e.menuCategoryId == categoryId);
      bundleCategoryList.refresh();
    }
  }
}
