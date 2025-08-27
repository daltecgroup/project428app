import 'dart:convert';
import 'package:abg_pos_app/app/data/models/Outlet.dart';
import 'package:abg_pos_app/app/data/repositories/user_outlet_repository.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:get/get.dart';
import '../utils/constants/app_constants.dart';
import '../utils/helpers/file_helper.dart';
import '../utils/helpers/logger_helper.dart';

class UserOutletDataController extends GetxController {
  UserOutletDataController({required this.repository});
  final UserOutletRepository repository;

  final Rx<Outlet?> currentOutlet = (null as Outlet?).obs;

  @override
  void onInit() {
    super.onInit();
    syncData(refresh: true);
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> syncData({bool? refresh}) async {
    if (box.getValue(AppConstants.KEY_IS_LOGGED_IN) == false ||
        box.isNull(AppConstants.KEY_IS_LOGGED_IN))
      return;

    try {
      final file = await getLocalFile(AppConstants.FILENAME_USER_OUTLET_DATA);
      if (await file.exists() && (refresh == null || refresh == false)) {
        LoggerHelper.logInfo(
          'USER OUTLET DATA CONT: Set initial current outlet from local data',
        );
        currentOutlet.value = Outlet.fromJson(
          json.decode(await file.readAsString()),
        );
      } else {
        LoggerHelper.logInfo(
          'USER OUTLET DATA CONT: Set initial current outlet from server',
        );
        final fetchedUserOutlet = await repository.getCurrentOutlet();
        if (fetchedUserOutlet != null) {
          currentOutlet.value = fetchedUserOutlet;
          await file.writeAsString(json.encode(fetchedUserOutlet));
        } else {
          LoggerHelper.logInfo(
            'USER OUTLET DATA CONT: Current outlet not found',
          );
        }
      }
    } catch (e) {
      LoggerHelper.logError(e.toString());
    }
  }

  // Future<void> setCurrentOutlet(String outletId){
  // }
}
