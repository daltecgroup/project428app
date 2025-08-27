import 'package:abg_pos_app/app/data/models/OutletInventoryTransaction.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/alert_snackbar.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/helpers/get_storage_helper.dart';

class OutletInventoryTransactionProvider extends GetConnect {
  final String url = '/outletinventorytransactions';
  @override
  void onInit() {
    _providerInit();
  }

  Future<Response<Map<String, dynamic>>> createOutletInventoryTransaction(
    dynamic data,
  ) async {
    Map<String, dynamic> body = {};
    final Response response = await post(url, data);
    body['message'] = response.body['message'] as String;
    if (response.body['errors'] != null) {
      body['errors'] = response.body['errors'];
    }
    return Response(
      statusCode: response.statusCode,
      statusText: response.statusText,
      body: body,
      headers: response.headers,
      request: response.request,
    );
  }

  Future<Response<Map<String, dynamic>>>
  createMultipleOutletInventoryTransaction(dynamic data) async {
    Map<String, dynamic> body = {};
    final Response response = await post('$url/bulk', data);
    body['message'] = response.body['message'] as String;
    if (response.body['errors'] != null) {
      body['errors'] = response.body['errors'];
    }
    return Response(
      statusCode: response.statusCode,
      statusText: response.statusText,
      body: body,
      headers: response.headers,
      request: response.request,
    );
  }

  Future<Response<List<OutletinventoryTransaction>>>
  getOutletInventoryTransactions({String? query}) async {
    final Response response = await get('$url$query');
    if (response.isOk && response.body is List) {
      final List<dynamic> jsonList = response.body;
      final List<OutletinventoryTransaction> oits = jsonList
          .map(
            (json) => OutletinventoryTransaction.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: oits,
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
