import 'package:abg_pos_app/app/controllers/menu_category_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_data_controller.dart';
import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:get/get.dart';

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
}
