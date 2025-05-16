import 'package:get/get.dart';

import '../controllers/pengaturan_admin_controller.dart';

class PengaturanAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengaturanAdminController>(
      () => PengaturanAdminController(),
    );
  }
}
