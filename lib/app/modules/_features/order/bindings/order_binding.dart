import 'package:get/get.dart';
import '../../../../controllers/order_data_controller.dart';
import '../../../../controllers/request_data_controller.dart';
import '../../../../controllers/user_data_controller.dart';
import '../../../../data/providers/order_provider.dart';
import '../../../../data/providers/request_provider.dart';
import '../../../../data/providers/user_provider.dart';
import '../../../../data/repositories/order_repository.dart';
import '../../../../controllers/outlet_data_controller.dart';
import '../../../../data/providers/outlet_provider.dart';
import '../../../../data/repositories/outlet_repository.dart';
import '../../../../data/repositories/request_repository.dart';
import '../../../../data/repositories/user_repository.dart';
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

    // request data
    Get.lazyPut<RequestProvider>(() => RequestProvider());
    Get.lazyPut<RequestRepository>(
      () => RequestRepository(provider: Get.find<RequestProvider>()),
    );
    Get.lazyPut<RequestDataController>(
      () => RequestDataController(repository: Get.find<RequestRepository>()),
    );

    // page controller
    Get.lazyPut<OrderDetailController>(
      () => OrderDetailController(
        data: Get.find<OrderDataController>(),
        outletData: Get.find<OutletDataController>(),
        userData: Get.find<UserDataController>(),
        requestData: Get.find<RequestDataController>()
      ),
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
