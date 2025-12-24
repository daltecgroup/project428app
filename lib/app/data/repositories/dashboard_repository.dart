import 'package:abg_pos_app/app/data/models/DashboardResponse.dart';
import 'package:abg_pos_app/app/data/providers/dashboard_provider.dart';
import 'package:get/get.dart';

class DashboardRepository extends GetxController {
  DashboardRepository({required this.provider});
  final DashboardProvider provider;

  Future<DashboardData?> fetchDashboardData(String? outletId) async {
    final Response response = await provider.fetchDashboardData(outletId);
    if (response.hasError || response.body == null) {
      return response.body;
    }
    if (response.statusCode != 200) {
      throw Exception(
        'Failed to fetch dashboard Data: ${response.statusCode} - ${response.statusText}}',
      );
    }
    return (response.body as DashboardResponse).data;
  }
}
