import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/controllers/user_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/outlet_provider.dart';
import 'package:abg_pos_app/app/data/repositories/outlet_repository.dart';
import 'package:get/get.dart';

import '../../../../controllers/order_data_controller.dart';
import '../../../../data/providers/order_provider.dart';
import '../../../../data/providers/user_provider.dart';
import '../../../../data/repositories/order_repository.dart';
import '../../../../data/repositories/user_repository.dart';
import '../controllers/outlet_detail_controller.dart';
import '../controllers/outlet_input_controller.dart';

import '../controllers/outlet_list_controller.dart';

class OutletBinding extends Bindings {
  @override
  void dependencies() {
    // outlet data
    Get.lazyPut<OutletProvider>(() => OutletProvider());
    Get.lazyPut<OutletRepository>(
      () => OutletRepository(provider: Get.find<OutletProvider>()),
    );
    Get.lazyPut<OutletDataController>(
      () => OutletDataController(repository: Get.find<OutletRepository>()),
    );

    // user data
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.lazyPut<UserRepository>(
      () => UserRepository(userProvider: Get.find<UserProvider>()),
    );
    Get.lazyPut<UserDataController>(
      () => UserDataController(userRepository: Get.find<UserRepository>()),
    );

    // order data
    Get.lazyPut<OrderProvider>(() => OrderProvider());
    Get.lazyPut<OrderRepository>(
      () => OrderRepository(provider: Get.find<OrderProvider>()),
    );
    Get.lazyPut<OrderDataController>(
      () => OrderDataController(repository: Get.find<OrderRepository>()),
    );

    // page controlelrs
    Get.lazyPut<OutletInputController>(
      () => OutletInputController(data: Get.find<OutletDataController>()),
    );
    Get.lazyPut<OutletDetailController>(
      () => OutletDetailController(
        data: Get.find<OutletDataController>(),
        userData: Get.find<UserDataController>(),
        orderData: Get.find<OrderDataController>(),
      ),
    );
    Get.lazyPut<OutletListController>(
      () => OutletListController(data: Get.find<OutletDataController>()),
    );
  }
}
