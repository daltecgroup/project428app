import 'dart:convert';

import 'package:abg_pos_app/app/data/models/AdminNotification.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/alert_snackbar.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/helpers/get_storage_helper.dart';

class AdminNotificationProvider extends GetConnect {
  final String url = '/admin-notifications';
  @override
  void onInit() {
    _providerInit();
  }

  Future<Response<List<AdminNotification>>> getAllNotifications() async {
    final Response response = await get(url);
    if (response.isOk) {
      final List<dynamic> jsonList = response.body['data']['notifications'];
      final List<AdminNotification> adminNotifications = jsonList
          .map((json) => AdminNotification.fromJson(json as Map<String, dynamic>))
          .toList();
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: adminNotifications,
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

  Future<Response<Map<String, dynamic>>> markAsOpen(
    String id,
  ) async {
    Map<String, dynamic> body = {};
    final Response response = await patch('$url/$id/open', json.encode({}));
    body['message'] = response.body['message'] as String;
    return Response(
      statusCode: response.statusCode,
      statusText: response.statusText,
      body: body,
      headers: response.headers,
      request: response.request,
    );
  }

  Future<Response<Map<String, dynamic>>> destroy(String id) async {
    Map<String, dynamic> body = {};
    final Response response = await delete('$url/$id');
    body['message'] = response.body['message'] as String;
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
