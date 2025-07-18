import 'package:get/get.dart';

import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/get_storage_helper.dart';

class AdminDashboardController extends GetxController {
  BoxHelper box = BoxHelper();

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
}
