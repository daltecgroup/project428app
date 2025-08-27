import 'package:get/get.dart';

import '../../../../controllers/outlet_data_controller.dart';
import '../../../../controllers/outlet_inventory_data_controller.dart';
import '../../outlet_inventory/controllers/outlet_inventory_controller.dart';

class OutletInventoryListController extends GetxController {
  OutletInventoryListController({
    required this.outletData,
    required this.data,
    required this.outletInventoryController
  });

  final OutletDataController outletData;
  final OutletInventoryDataController data;
  final OutletInventoryController outletInventoryController;
  final String backRoute = Get.previousRoute;
  
  
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
