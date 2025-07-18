import 'package:abg_pos_app/app/utils/services/auth_service.dart';
import 'package:abg_pos_app/app/utils/services/setting_service.dart';
import 'package:get/get.dart';

import '../../../../controllers/outlet_data_controller.dart';
import '../../../../data/providers/outlet_provider.dart';
import '../../../../data/repositories/outlet_repository.dart';
import '../controllers/select_role_controller.dart';

class SelectRoleBinding extends Bindings {
  @override
  void dependencies() {
    // outlet data
    Get.lazyPut<OutletProvider>(() => OutletProvider());
    Get.lazyPut<OutletRepository>(
      () => OutletRepository(provider: Get.find<OutletProvider>()),
    );
    Get.lazyPut<OutletDataController>(
      () => OutletDataController(repository: Get.find<OutletRepository>()),
    );

    Get.lazyPut<SelectRoleController>(
      () => SelectRoleController(
        auth: Get.find<AuthService>(),
        outletData: Get.find<OutletDataController>(),
        setting: Get.find<SettingService>(),
      ),
    );
  }
}
