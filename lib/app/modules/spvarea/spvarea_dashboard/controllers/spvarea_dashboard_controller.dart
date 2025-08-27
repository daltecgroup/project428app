import 'package:get/get.dart';

import '../../../../data/models/User.dart';
import '../../../../utils/services/auth_service.dart';

class SpvareaDashboardController extends GetxController {
  final auth = Get.find<AuthService>();
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  User? get currentUser {
    return auth.currentUser.value;
  }
}
