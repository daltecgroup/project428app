import 'package:get/get.dart';

import '../controllers/user_update_controller.dart';

class UserUpdateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserUpdateController>(
      () => UserUpdateController(),
    );
  }
}
