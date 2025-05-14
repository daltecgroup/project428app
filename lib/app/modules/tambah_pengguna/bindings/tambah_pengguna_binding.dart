import 'package:get/get.dart';

import '../controllers/tambah_pengguna_controller.dart';

class TambahPenggunaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahPenggunaController>(
      () => TambahPenggunaController(),
    );
  }
}
