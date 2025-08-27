import 'dart:convert';

import 'package:abg_pos_app/app/data/models/Outlet.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/alert_snackbar.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/helpers/get_storage_helper.dart';

class UserOutletProvider extends GetConnect {
  final String url = '/useroutlets';
  @override
  void onInit() {
    _providerInit();
  }

  Future<Response<Map<String, dynamic>>> setCurrentOutlet(
    String outletId,
  ) async {
    Map<String, dynamic> body = {};
    final Response response = await post(
      url,
      json.encode({'outletId': outletId}),
    );
    body['message'] = response.body['message'] as String;
    if (response.body['errors'] != null) {
      body['errors'] = response.body['errors'];
    }
    if (response.body['userOutlet'] != null) {
      body['userOutlet'] = Outlet.fromJson(response.body['userOutlet']);
    }
    return Response(
      statusCode: response.statusCode,
      statusText: response.statusText,
      body: body,
      headers: response.headers,
      request: response.request,
    );
  }

  Future<Response<Map<String, dynamic>>> getCurrentOutlet() async {
    Map<String, dynamic> body = {};
    final Response response = await get(url);
    body['message'] = response.body['message'] as String;
    if (response.body['errors'] != null) {
      body['errors'] = response.body['errors'];
    }
    if (response.body['userOutlet'] != null) {
      body['userOutlet'] = Outlet.fromJson(response.body['userOutlet']);
    }
    return Response(
      statusCode: response.statusCode,
      statusText: response.statusText,
      body: body,
      headers: response.headers,
      request: response.request,
    );
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
