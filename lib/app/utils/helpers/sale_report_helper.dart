import 'package:abg_pos_app/app/controllers/daily_outlet_sale_report_data_controller.dart';
import 'package:get/get.dart';

void clearCurrentDailyOutletSaleReport() {
  if (Get.isRegistered<DailyOutletSaleReportDataController>()) {
    final data = Get.find<DailyOutletSaleReportDataController>();
    data.clearCurrentReport();
  }
}

Future<void> resyncCurrentDailyOutletSaleReport() async {
  if (Get.isRegistered<DailyOutletSaleReportDataController>()) {
    final data = Get.find<DailyOutletSaleReportDataController>();
    await data.syncData();
  }
}
