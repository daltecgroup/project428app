import 'package:get/get.dart';

import '../controllers/aktivitas_admin_controller.dart';

class AktivitasAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AktivitasAdminController>(
      () => AktivitasAdminController(),
    );
  }
}
