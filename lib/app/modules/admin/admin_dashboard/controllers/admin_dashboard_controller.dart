import 'package:abg_pos_app/app/utils/services/auth_service.dart';
import 'package:get/get.dart';

import '../../../../data/models/User.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/get_storage_helper.dart';

class AdminDashboardController extends GetxController {
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

  String get currentRole {
    return box.getValue(AppConstants.KEY_CURRENT_ROLE);
  }

  User? get currentUser {
    return auth.currentUser.value;
  }
}
