import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:get/get.dart';

import '../../../../controllers/daily_outlet_sale_report_data_controller.dart';
import '../../../../data/models/User.dart';
import '../../../../utils/services/auth_service.dart';

class OperatorDashboardController extends GetxController {
  OperatorDashboardController({
    required this.outletData,
    required this.reportData,
  });
  final OutletDataController outletData;
  final DailyOutletSaleReportDataController reportData;
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

  Future<void> refreshData() async {
    await outletData.syncData(refresh: true);
    await reportData.syncData();
  }

  String get currentRole {
    return box.getValue(AppConstants.KEY_CURRENT_ROLE);
  }

  User? get currentUser {
    return auth.currentUser.value;
  }
}
