import 'package:abg_pos_app/app/controllers/dashboard_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/dashboard_provider.dart';
import 'package:abg_pos_app/app/data/repositories/dashboard_repository.dart';
import 'package:get/get.dart';

import '../controllers/admin_dashboard_controller.dart';

class AdminDashboardBinding extends Bindings {
  @override
  void dependencies() {
    // addons data
    Get.lazyPut<DashboardProvider>(() => DashboardProvider());
    Get.lazyPut<DashboardRepository>(
      () => DashboardRepository(provider: Get.find<DashboardProvider>()),
    );
    Get.lazyPut<DashboardDataController>(
      () => DashboardDataController(repository: Get.find<DashboardRepository>()),
    );
    Get.lazyPut<AdminDashboardController>(
      () => AdminDashboardController(data: Get.find<DashboardDataController>()),
    );
  }
}
