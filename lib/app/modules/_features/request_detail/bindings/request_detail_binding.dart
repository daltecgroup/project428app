import 'package:get/get.dart';

import '../../../../controllers/request_data_controller.dart';
import '../../../../data/providers/request_provider.dart';
import '../../../../data/repositories/request_repository.dart';
import '../controllers/request_detail_controller.dart';

class RequestDetailBinding extends Bindings {
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
    Get.lazyPut<RequestDetailController>(
      () => RequestDetailController(data: Get.find<RequestDataController>()),
    );
  }
}
