import 'package:get/get.dart';

import '../controllers/gerai_controller.dart';

class GeraiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GeraiController>(
      () => GeraiController(),
    );
  }
}
