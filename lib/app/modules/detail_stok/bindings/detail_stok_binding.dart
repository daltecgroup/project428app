import 'package:get/get.dart';

import '../controllers/detail_stok_controller.dart';

class DetailStokBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailStokController>(
      () => DetailStokController(),
    );
  }
}
