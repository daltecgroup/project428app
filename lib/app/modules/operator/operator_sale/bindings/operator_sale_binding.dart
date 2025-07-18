import 'package:get/get.dart';

import '../../../../utils/services/sale_service.dart';
import '../controllers/operator_sale_controller.dart';

class OperatorSaleBinding extends Bindings {
  @override
  void dependencies() {
    // ensure SaleService is registered
    SaleService service = Get.isRegistered<SaleService>()
        ? Get.find<SaleService>()
        : Get.put(SaleService());

    Get.lazyPut<OperatorSaleController>(
      () => OperatorSaleController(service: service),
    );
  }
}
