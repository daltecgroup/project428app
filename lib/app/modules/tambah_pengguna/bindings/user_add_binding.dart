import 'package:get/get.dart';

import '../controllers/user_add_controller.dart';

class TambahPenggunaBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserAddController>(() => UserAddController());
  }
}
