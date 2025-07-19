import 'package:abg_pos_app/app/controllers/sale_data_controller.dart';
import 'package:abg_pos_app/app/data/providers/sale_provider.dart';
import 'package:abg_pos_app/app/data/repositories/sale_repository.dart';
import 'package:get/get.dart';

import '../../../../utils/services/sale_service.dart';
import '../controllers/operator_sale_controller.dart';

class OperatorSaleBinding extends Bindings {
  @override
  void dependencies() {
    // sale data
    Get.lazyPut<SaleProvider>(() => SaleProvider());
    Get.lazyPut<SaleRepository>(
      () => SaleRepository(provider: Get.find<SaleProvider>()),
    );
    Get.lazyPut<SaleDataController>(
      () => SaleDataController(repository: Get.find<SaleRepository>()),
    );

    // ensure SaleService is registered
    SaleService service = Get.isRegistered<SaleService>()
        ? Get.find<SaleService>()
        : Get.put(SaleService());

    Get.lazyPut<OperatorSaleController>(
      () => OperatorSaleController(
        service: service,
        data: Get.find<SaleDataController>(),
      ),
    );
  }
}
