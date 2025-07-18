import 'package:get/get.dart';

import '../../../../controllers/outlet_data_controller.dart';
import '../../../../data/providers/outlet_provider.dart';
import '../../../../data/repositories/outlet_repository.dart';
import '../controllers/operator_dashboard_controller.dart';

class OperatorDashboardBinding extends Bindings {
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
    Get.lazyPut<OperatorDashboardController>(
      () => OperatorDashboardController(
        outletData: Get.find<OutletDataController>(),
      ),
    );
  }
}
