import 'package:abg_pos_app/app/controllers/sale_data_controller.dart';
import 'package:abg_pos_app/app/controllers/user_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/user_provider.dart';
import 'package:abg_pos_app/app/data/repositories/user_repository.dart';
import 'package:get/get.dart';

import '../../../../controllers/request_data_controller.dart';
import '../../../../data/providers/request_provider.dart';
import '../../../../data/providers/sale_provider.dart';
import '../../../../data/repositories/request_repository.dart';
import '../../../../data/repositories/sale_repository.dart';
import '../controllers/operator_sale_detail_controller.dart';

class OperatorSaleDetailBinding extends Bindings {
  @override
  void dependencies() {
    // sale data
    Get.lazyPut<SaleProvider>(() => SaleProvider());
    Get.lazyPut<SaleRepository>(
      () => SaleRepository(provider: Get.find<SaleProvider>()),
    );
    Get.lazyPut<SaleDataController>(
      () => SaleDataController(repository: Get.find<SaleRepository>()),
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

    Get.lazyPut<OperatorSaleDetailController>(
      () => OperatorSaleDetailController(
        data: Get.find<SaleDataController>(),
        userData: Get.find<UserDataController>(),
        requestData: Get.find<RequestDataController>(),
      ),
    );
  }
}
