import 'package:get/get.dart';
import '../../../../controllers/order_data_controller.dart';
import '../../../../data/models/Order.dart';
import '../../../../utils/constants/order_constants.dart';

class OrderListController extends GetxController {
  OrderListController({required this.data, this.outletId});
  final OrderDataController data;
  final List<String>? outletId;

  final String backRoute = Get.previousRoute;

  RxBool openActive = true.obs;
  RxBool openHistory = true.obs;

  @override
  void onInit() {
    super.onInit();
    refreshData();
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
  }

  List<Order> activeOrder() {
    return data.filteredOrders([
      OrderConstants.ORDERED,
      OrderConstants.PROCESSED,
      OrderConstants.ON_THE_WAY,
    ], outletId: outletId);
  }

  Map<String, List<Order>> groupedOrders() {
    return data.groupedOrders([
      OrderConstants.ACCEPTED,
      OrderConstants.RETURNED,
      OrderConstants.FAILED,
    ], outletId: outletId);
  }
}
