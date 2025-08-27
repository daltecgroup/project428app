import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:get/get.dart';
import '../../../../controllers/order_data_controller.dart';
import '../../../../shared/pages/order_list/controllers/order_list_controller.dart';

class OutletOrderListController extends GetxController {
  OutletOrderListController({
    required this.outletData,
    required this.data,
    required this.listController,
  });
  final OutletDataController outletData;
  final OrderDataController data;
  final OrderListController listController;

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
