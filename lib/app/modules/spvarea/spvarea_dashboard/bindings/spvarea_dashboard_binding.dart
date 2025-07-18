import 'package:get/get.dart';

import '../controllers/spvarea_dashboard_controller.dart';

class SpvareaDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpvareaDashboardController>(
      () => SpvareaDashboardController(),
    );
  }
}
