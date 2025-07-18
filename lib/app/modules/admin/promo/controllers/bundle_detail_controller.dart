import 'package:abg_pos_app/app/controllers/menu_category_data_controller.dart';
import 'package:get/get.dart';

import '../../../../controllers/bundle_data_controller.dart';

class BundleDetailController extends GetxController {
  BundleDetailController({required this.data, required this.categoryData});
  final BundleDataController data;
  final MenuCategoryDataController categoryData;

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
    await data.syncData(refresh: true);
    await categoryData.syncData(refresh: true);
  }
}
