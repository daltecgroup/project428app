import 'package:get/get.dart';

import '../controllers/absensi_operator_controller.dart';

class AbsensiOperatorBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AbsensiOperatorController>(
      () => AbsensiOperatorController(),
    );
  }
}
