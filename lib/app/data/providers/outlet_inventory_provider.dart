import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/alert_snackbar.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/helpers/get_storage_helper.dart';
import '../models/OutletInventory.dart';

class OutletInventoryProvider extends GetConnect {
  final String url = '/outletinventory';
  @override
  void onInit() {
    _providerInit();
  }

  Future<Response<OutletInventory?>> getOutletInventory(String outletId) async {
    final Response response = await get('$url/$outletId');
    if (response.isOk) {
      final json = response.body;
      final OutletInventory outletInventory = OutletInventory.fromJson(
        json as Map<String, dynamic>,
      );
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: outletInventory,
        headers: response.headers,
        request: response.request,
      );
    } else {
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
