import 'package:get/get.dart';
import '../../../../controllers/order_data_controller.dart';
import '../../../../data/providers/order_provider.dart';
import '../../../../data/repositories/order_repository.dart';
import '../../../../controllers/outlet_data_controller.dart';
import '../../../../data/providers/outlet_provider.dart';
import '../../../../data/repositories/outlet_repository.dart';
import '../controllers/order_detail_controller.dart';
import '../controllers/order_input_controller.dart';
import '../../../../shared/pages/order_list/controllers/order_list_controller.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    // order data
    Get.lazyPut<OrderProvider>(() => OrderProvider());
    Get.lazyPut<OrderRepository>(
      () => OrderRepository(provider: Get.find<OrderProvider>()),
    );
    Get.lazyPut<OrderDataController>(
      () => OrderDataController(repository: Get.find<OrderRepository>()),
    );

    // outlet data
    // outlet data
    Get.lazyPut<OutletProvider>(() => OutletProvider());
    Get.lazyPut<OutletRepository>(
      () => OutletRepository(provider: Get.find<OutletProvider>()),
    );
    Get.lazyPut<OutletDataController>(
      () => OutletDataController(repository: Get.find<OutletRepository>()),
    );

    // page controller
    Get.lazyPut<OrderDetailController>(
      () => OrderDetailController(data: Get.find<OrderDataController>()),
    );
    Get.lazyPut<OrderInputController>(
      () => OrderInputController(
        data: Get.find<OrderDataController>(),
        outletData: Get.find<OutletDataController>(),
      ),
    );
    Get.lazyPut<OrderListController>(
      () => OrderListController(data: Get.find<OrderDataController>()),
    );
  }
}
