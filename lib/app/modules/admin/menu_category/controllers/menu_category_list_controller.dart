import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';
import '../../../../shared/custom_alert.dart';
import '../../../../data/models/MenuCategory.dart';
import '../../../../utils/helpers/text_helper.dart';
import '../../../../utils/helpers/get_storage_helper.dart';
import '../../../../controllers/menu_category_data_controller.dart';

class MenuCategoryListController extends GetxController {
  MenuCategoryListController({required this.data});
  MenuCategoryDataController data;
  late BoxHelper box;
  final String backRoute = Get.previousRoute;

  @override
  Future<void> onInit() async {
    super.onInit();
    box = BoxHelper();
    await data.syncData();
  }

  Future<void> refreshCategories() => data.syncData(refresh: true);

  List<MenuCategory> filteredCategories({bool? status}) {
    List<MenuCategory> list = data.categories;
    if (status != null) {
      list = data.categories.where((p0) => p0.isActive == status).toList();
    }
    return list;
  }

  void showActions({
    required String categoryId,
    required bool currentStatus,
    required String name,
  }) {
    customActionDialog(
      title: normalizeName(name),
      currentStatus: currentStatus,
      edit: () {
        Get.back();
        data.selectedMenuCategory.value = data.categories.firstWhereOrNull(
          (e) => e.id == categoryId,
        );
        Get.toNamed(Routes.MENU_CATEGORY_INPUT);
      },
      toggleStatus: () async {
        Get.back();
        await data.changeStatus(categoryId, !currentStatus);
      },
      delete: () {
        Get.back();
        data.deleteConfirmation(categoryId, name);
      },
    );
  }
}
