import 'package:get/get.dart';

import '../controllers/homepage_spvarea_controller.dart';

class HomepageSpvareaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageSpvareaController>(
      () => HomepageSpvareaController(),
    );
  }
}
