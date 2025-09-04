import 'package:abg_pos_app/app/data/models/DailyOutletSaleReport.dart';
import 'package:abg_pos_app/app/utils/helpers/outlet_helper.dart';
import 'package:abg_pos_app/app/utils/helpers/time_helper.dart';
import 'package:abg_pos_app/app/utils/services/auth_service.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/alert_snackbar.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/helpers/get_storage_helper.dart';

class DailyOutletSaleReportProvider extends GetConnect {
  final String url = '/dailyoutletsalereports';
  @override
  void onInit() {
    _providerInit();
  }

  Future<Response<DailyOutletSaleReport>>
  getSingleDailyOutletSaleReport() async {
    if (currentOutletId == null) {
      Get.find<AuthService>().logout();
    }

    final Response response = await get(
      '$url/${currentOutletId}_$currentDateString',
    );
    if (response.isOk) {
      final DailyOutletSaleReport report = DailyOutletSaleReport.fromJson(
        response.body,
      );
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: report,
        headers: response.headers,
        request: response.request,
      );
    } else {
      // if (response.body['message'] != null)
      //   Get.snackbar('Peringatan', response.body['message']);
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: null,
        headers: response.headers,
        request: response.request,
      );
    }
  }

  void _providerInit() {
    httpClient.baseUrl = AppConstants.CURRENT_BASE_API_URL;
    httpClient.timeout = const Duration(seconds: 5);
    httpClient.addRequestModifier<dynamic>((request) {
      request.headers['Authorization'] =
          'Bearer ${box.getValue(AppConstants.KEY_USER_TOKEN) ?? ''}';
      return request;
    });
    httpClient.addResponseModifier<dynamic>((request, response) {
      if (response.status.isForbidden || response.unauthorized) {
        Get.offNamed(Routes.AUTH);
        unauthorizedSnackbar();
      }
      return response;
    });
  }
}
