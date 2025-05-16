import 'package:get/get.dart';

import '../controllers/ubah_pengguna_controller.dart';

class UbahPenggunaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UbahPenggunaController>(
      () => UbahPenggunaController(),
    );
  }
}
