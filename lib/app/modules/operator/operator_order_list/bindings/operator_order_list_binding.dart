import 'package:abg_pos_app/app/shared/pages/order_list/controllers/order_list_controller.dart';
import 'package:get/get.dart';

import '../../../../controllers/order_data_controller.dart';
import '../../../../data/providers/order_provider.dart';
import '../../../../data/repositories/order_repository.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/get_storage_helper.dart';
import '../controllers/operator_order_list_controller.dart';

class OperatorOrderListBinding extends Bindings {
  @override
  void dependencies() {
    final String? currentOutlet = box.getValue(AppConstants.KEY_CURRENT_OUTLET);
    // order data
    Get.lazyPut<OrderProvider>(() => OrderProvider());
    Get.lazyPut<OrderRepository>(
      () => OrderRepository(provider: Get.find<OrderProvider>()),
    );
    Get.lazyPut<OrderDataController>(
      () => OrderDataController(repository: Get.find<OrderRepository>()),
    );
    Get.lazyPut<OrderListController>(
      () => OrderListController(
        data: Get.find<OrderDataController>(),
        outletId: currentOutlet != null ? [currentOutlet] : null,
      ),
    );
    Get.lazyPut<OperatorOrderListController>(
      () => OperatorOrderListController(
        listController: Get.find<OrderListController>(),
      ),
    );
  }
}
