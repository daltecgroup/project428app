import 'package:abg_pos_app/app/controllers/request_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/request_provider.dart';
import 'package:abg_pos_app/app/data/repositories/request_repository.dart';
import 'package:get/get.dart';

import '../controllers/request_controller.dart';

class RequestBinding extends Bindings {
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
    Get.lazyPut<RequestController>(
      () => RequestController(data: Get.find<RequestDataController>()),
    );
  }
}
