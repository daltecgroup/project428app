import 'package:get/get.dart';

import '../controllers/aktivitas_operator_controller.dart';

class AktivitasOperatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AktivitasOperatorController>(
      () => AktivitasOperatorController(),
    );
  }
}
