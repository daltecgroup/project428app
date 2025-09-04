import 'package:get/get.dart';

import '../controllers/outlet_menu_pricing_detail_controller.dart';

class OutletMenuPricingDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutletMenuPricingDetailController>(
      () => OutletMenuPricingDetailController(),
    );
  }
}
