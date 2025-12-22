import 'package:get/get.dart';

import '../../../../controllers/request_data_controller.dart';
import '../../../../data/providers/request_provider.dart';
import '../../../../data/repositories/request_repository.dart';
import '../controllers/operator_request_controller.dart';

class OperatorRequestBinding extends Bindings {
  @override
  void dependencies() {
    // request data
    Get.lazyPut<RequestProvider>(() => RequestProvider());
    Get.lazyPut<RequestRepository>(
      () => RequestRepository(provider: Get.find<RequestProvider>()),
    );
    Get.lazyPut<RequestDataController>(
      () => RequestDataController(repository: Get.find<RequestRepository>()),
    );
    Get.lazyPut<OperatorRequestController>(
      () => OperatorRequestController(data: Get.find<RequestDataController>()),
    );
  }
}
