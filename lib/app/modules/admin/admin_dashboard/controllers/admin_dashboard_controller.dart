import 'package:abg_pos_app/app/controllers/dashboard_data_controller.dart';
import 'package:abg_pos_app/app/utils/services/auth_service.dart';
import 'package:get/get.dart';

import '../../../../data/models/User.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/helpers/get_storage_helper.dart';

class AdminDashboardController extends GetxController {
  AdminDashboardController({required this.data});
  final auth = Get.find<AuthService>();
  final DashboardDataController data;

  String get currentRole => box.getValue(AppConstants.KEY_CURRENT_ROLE);

  User? get currentUser => auth.currentUser.value;

  Future<void> refreshData() => data.syncData(refresh: true);
}
