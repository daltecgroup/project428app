import 'package:get/get.dart';
import '../../../../controllers/order_data_controller.dart';
import '../../../../shared/pages/order_list/controllers/order_list_controller.dart';
import '../../../../utils/helpers/get_storage_helper.dart';

class OutletOrderListController extends GetxController {
  OutletOrderListController({required this.data, required this.listController});
  OrderDataController data;
  OrderListController listController;

  late BoxHelper box;
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
