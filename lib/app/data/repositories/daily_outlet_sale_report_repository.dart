import 'package:abg_pos_app/app/data/models/DailyOutletSaleReport.dart';
import 'package:abg_pos_app/app/data/providers/daily_outlet_sale_report_provider.dart';
import 'package:get/get.dart';

class DailyOutletSaleReportRepository extends GetxController {
  DailyOutletSaleReportRepository({required this.provider});
  final DailyOutletSaleReportProvider provider;

  Future<DailyOutletSaleReport> getSingleDailyOutletSaleReport() async {
    final Response response = await provider.getSingleDailyOutletSaleReport();
    if (response.hasError) {
      throw Exception(
        'Failed to fetch single daily outlet sale report: ${response.statusCode} - ${response.statusText ?? ''}',
      );
    }
    return response.body;
  }
}
