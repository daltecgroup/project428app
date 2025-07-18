import 'package:abg_pos_app/app/utils/services/sale_service.dart';
import 'package:get/get.dart';

import '../../../../routes/app_pages.dart';
import '../../../_features/select_sale_item/controllers/select_sale_item_controller.dart';

class OperatorSaleController extends GetxController {
  OperatorSaleController({required this.service});
  final SaleService service;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addSaleItem() {
    service.selectedPendingSale.value = null;
    if (Get.isRegistered<SelectSaleItemController>()) {
      final c = Get.find<SelectSaleItemController>();
      c.selectedBundle.clear();
      c.selectedMenu.clear();
    }
    Get.toNamed(Routes.SELECT_SALE_ITEM);
  }
}
