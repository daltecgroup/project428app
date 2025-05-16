import 'package:get/get.dart';

import '../controllers/tambah_stok_controller.dart';

class TambahStokBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TambahStokController>(
      () => TambahStokController(),
    );
  }
}
