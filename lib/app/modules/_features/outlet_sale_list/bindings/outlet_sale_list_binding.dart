import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/controllers/sale_data_controller.dart';
import 'package:get/get.dart';

import '../../../../data/providers/outlet_provider.dart';
import '../../../../data/providers/sale_provider.dart';
import '../../../../data/repositories/outlet_repository.dart';
import '../../../../data/repositories/sale_repository.dart';
import '../controllers/outlet_sale_list_controller.dart';

class OutletSaleListBinding extends Bindings {
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

    // sale data
    Get.lazyPut<SaleProvider>(() => SaleProvider());
    Get.lazyPut<SaleRepository>(
      () => SaleRepository(provider: Get.find<SaleProvider>()),
    );
    Get.lazyPut<SaleDataController>(
      () => SaleDataController(repository: Get.find<SaleRepository>()),
    );

    Get.lazyPut<OutletSaleListController>(
      () => OutletSaleListController(
        outletData: Get.find<OutletDataController>(),
        data: Get.find<SaleDataController>(),
      ),
    );
  }
}
