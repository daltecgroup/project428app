import 'package:get/get.dart';

import '../controllers/beranda_operator_controller.dart';

class BerandaOperatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BerandaOperatorController>(
      () => BerandaOperatorController(),
    );
  }
}
