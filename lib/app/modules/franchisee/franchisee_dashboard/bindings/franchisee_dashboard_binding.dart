import 'package:get/get.dart';

import '../controllers/franchisee_dashboard_controller.dart';

class FranchiseeDashboardBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FranchiseeDashboardController>(
      () => FranchiseeDashboardController(),
    );
  }
}
