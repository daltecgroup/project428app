import 'package:abg_pos_app/app/controllers/printer_controller.dart';
import 'package:abg_pos_app/app/controllers/sale_data_controller.dart';
import 'package:abg_pos_app/app/controllers/user_data_controller.dart';
import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:get/get.dart';

import '../../../../controllers/request_data_controller.dart';
import '../../../../utils/constants/string_value.dart';

class OperatorSaleDetailController extends GetxController {
  OperatorSaleDetailController({required this.data, required this.userData, required this.requestData});
  final SaleDataController data;
  final UserDataController userData;
  final RequestDataController requestData;
  final backRoute = Get.previousRoute;

  final PrinterController printer = Get.isRegistered<PrinterController>()
      ? Get.find<PrinterController>()
      : Get.put(PrinterController());

  RxBool showPrintHistory = true.obs;

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

  Future<void> printInvoice(String id) async {
    if (data.selectedSale.value != null) {
      await printer.startPrinting(data.selectedSale.value!, data: data, id: id);
    } else {
      customAlertDialog('Data Penjualan tidak ditemukan');
    }
  }

  void deleteRequest({required String saleCode, required String saleId}) {
    customDeleteAlertDialog('Yakin meminta penjualan $saleCode dihapus?', () {
      
    });
  }

  String getUserName(String id) {
    final user = userData.getUser(id);
    if (user == null) return 'admin';
    return user.name;
  }

  Future<void> createDeleteRequest() async {
    final selectedSale = data.selectedSale.value;

    if (selectedSale == null) {
      await customAlertDialog('Tidak ada penjualan yang dipilih');
      return;
    }
    
    requestData.createRequest(
      selectedSale.outlet.outletId,
      StringValue.DEL_SALE,
      selectedSale.id,
    );
  }
}
