import 'package:abg_pos_app/app/data/models/DailyOutletSaleReport.dart';
import 'package:abg_pos_app/app/data/repositories/daily_outlet_sale_report_repository.dart';
import 'package:abg_pos_app/app/utils/helpers/logger_helper.dart';
import 'package:get/get.dart';

class DailyOutletSaleReportDataController extends GetxController {
  DailyOutletSaleReportDataController({required this.repository});
  final DailyOutletSaleReportRepository repository;

  final Rx<DailyOutletSaleReport?> currentReport =
      (null as DailyOutletSaleReport?).obs;

  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    syncData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> syncData() async {
    isLoading.value = true;
    try {
      LoggerHelper.logInfo('DOSR: Sync daily outlet sale report data...');
      currentReport.value = await repository.getSingleDailyOutletSaleReport();
      if (currentReport.value != null)
        LoggerHelper.logInfo('DOSR: Sync success');
    } catch (e) {
      LoggerHelper.logInfo(e.toString());
      clearCurrentReport();
    } finally {
      isLoading.value = false;
    }
  }

  void clearCurrentReport() {
    currentReport.value = null as DailyOutletSaleReport?;
  }
}
