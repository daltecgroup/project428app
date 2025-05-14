import 'package:get/get.dart';

import '../controllers/detail_pengguna_controller.dart';

class DetailPenggunaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPenggunaController>(
      () => DetailPenggunaController(),
    );
  }
}
