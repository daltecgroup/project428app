import 'package:get/get.dart';

import '../controllers/login_as_controller.dart';

class LoginAsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginAsController>(
      () => LoginAsController(),
    );
  }
}
