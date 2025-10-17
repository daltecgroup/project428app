import 'package:get/get.dart';

import '../../../../controllers/daily_outlet_sale_report_data_controller.dart';
import '../../../../controllers/outlet_data_controller.dart';
import '../../../../data/providers/daily_outlet_sale_report_provider.dart';
import '../../../../data/providers/outlet_provider.dart';
import '../../../../data/repositories/daily_outlet_sale_report_repository.dart';
import '../../../../data/repositories/outlet_repository.dart';
import '../controllers/operator_dashboard_controller.dart';

class OperatorDashboardBinding extends Bindings {
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

    // daily outlet sale report data
    Get.lazyPut<DailyOutletSaleReportProvider>(
      () => DailyOutletSaleReportProvider(),
    );
    Get.lazyPut<DailyOutletSaleReportRepository>(
      () => DailyOutletSaleReportRepository(
        provider: Get.find<DailyOutletSaleReportProvider>(),
      ),
    );
    Get.lazyPut<DailyOutletSaleReportDataController>(
      () => DailyOutletSaleReportDataController(
        repository: Get.find<DailyOutletSaleReportRepository>(),
      ),
    );

    Get.lazyPut<OperatorDashboardController>(
      () => OperatorDashboardController(
        outletData: Get.find<OutletDataController>(),
        reportData: Get.find<DailyOutletSaleReportDataController>(),
      ),
    );
  }
}
