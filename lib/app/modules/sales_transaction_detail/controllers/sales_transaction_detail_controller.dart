import 'package:get/get.dart';
import 'package:project428app/app/data/providers/sale_data_provider.dart';
import 'package:project428app/app/services/operator_service.dart';

import '../../../data/models/sale.dart';

class SalesTransactionDetailController extends GetxController {
  OperatorService OperatorS = Get.find<OperatorService>();
  SaleDataProvider SaleP = SaleDataProvider();
  Rx<Sale?> invoice = (null as Sale?).obs;

  final count = 0.obs;
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

  void setInvoice(String code) {
    invoice.value = OperatorS.closedSales.firstWhereOrNull(
      (sale) => sale.code == code,
    );
  }

  void getInvoice(String code) {
    SaleP.getSaleById(code).then((res) {
      if (res.statusCode == 200) {
        invoice.value = Sale.fromJson(res.body);
      } else {
        print(res.body);
      }
    });
  }
}
