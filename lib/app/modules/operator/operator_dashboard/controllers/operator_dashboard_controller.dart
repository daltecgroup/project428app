import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:get/get.dart';

class OperatorDashboardController extends GetxController {
  OperatorDashboardController({required this.outletData});
  final OutletDataController outletData;
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
