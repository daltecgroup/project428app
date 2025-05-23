import 'package:get/get.dart';

import '../controllers/homepage_franchisee_controller.dart';

class HomepageFranchiseeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomepageFranchiseeController>(
      () => HomepageFranchiseeController(),
    );
  }
}
