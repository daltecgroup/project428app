import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/shared/pages/order_list/controllers/order_list_controller.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:get/get.dart';

import '../../../../controllers/order_data_controller.dart';
import '../../../../data/providers/order_provider.dart';
import '../../../../data/providers/outlet_provider.dart';
import '../../../../data/repositories/order_repository.dart';
import '../../../../data/repositories/outlet_repository.dart';
import '../../../../utils/constants/app_constants.dart';
import '../controllers/outlet_order_list_controller.dart';

class OutletOrderListBinding extends Bindings {
  BoxHelper box = BoxHelper();
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

    // outlet data
    Get.lazyPut<OutletProvider>(() => OutletProvider());
    Get.lazyPut<OutletRepository>(
      () => OutletRepository(provider: Get.find<OutletProvider>()),
    );
    Get.lazyPut<OutletDataController>(
      () => OutletDataController(repository: Get.find<OutletRepository>()),
    );

    Get.lazyPut<OutletOrderListController>(
      () => OutletOrderListController(
        data: Get.find<OrderDataController>(),
        outletData: Get.find<OutletDataController>(),
        listController: Get.find<OrderListController>(),
      ),
    );
  }
}
