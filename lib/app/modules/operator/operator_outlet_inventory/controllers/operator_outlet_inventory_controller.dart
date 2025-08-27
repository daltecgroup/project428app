import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:get/get.dart';

class OperatorOutletInventoryController extends GetxController {
  OperatorOutletInventoryController({required this.outletData});
  final OutletDataController outletData;
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

  String get currentOutletName {
    return outletData.currentOutletName;
  }
}
