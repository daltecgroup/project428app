import '../../../../controllers/outlet_data_controller.dart';
import '../../../../shared/custom_alert.dart';
import '../../../../utils/helpers/get_storage_helper.dart';
import '../../../../utils/helpers/logger_helper.dart';
import '../../../../utils/services/auth_service.dart';
import '../../../../utils/services/setting_service.dart';
import 'package:get/get.dart';

import '../../../../data/models/Outlet.dart';
import '../../../../data/models/User.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/constants/app_constants.dart';

class SelectRoleController extends GetxController {
  SelectRoleController({
    required this.auth,
    required this.outletData,
    required this.setting,
  });
  final AuthService auth;
  final OutletDataController outletData;
  final SettingService setting;
  RxList roles = [].obs;
  BoxHelper box = BoxHelper();

  @override
  void onInit() {
    super.onInit();
    roles.value = auth.getRoles;
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void logout() {
    auth.logout();
  }

  User? get currentUser {
    return auth.currentUser.value;
  }

  Future<dynamic> loginAsOperator() async {
    final currentUser = auth.currentUserFromStorage;
    if (currentUser == null) return auth.logout();

    final outlets = outletData.getOutletByOperatorId(currentUser.id);
    if (outlets.isEmpty) {
      return customAlertDialog('Anda belum ditugaskan di Gerai manapun');
    }

    final Outlet? selectedOutlet = outlets.length == 1
        ? outlets.first
        : await Get.toNamed(Routes.SELECT_OUTLET) as Outlet?;

    if (selectedOutlet == null) {
      return;
    }

    await _setOperatorSession(selectedOutlet);
    return Get.toNamed(Routes.OPERATOR_DASHBOARD);
  }

  Future<void> _setOperatorSession(Outlet outlet) async {
    setting.currentRole.value = AppConstants.ROLE_OPERATOR;
    await box.setValue(
      AppConstants.KEY_CURRENT_ROLE,
      AppConstants.ROLE_OPERATOR,
    );
    await box.setValue(AppConstants.KEY_CURRENT_OUTLET, outlet.id);
    LoggerHelper.logInfo('Operator login ke gerai ${outlet.name}');
  }
}
