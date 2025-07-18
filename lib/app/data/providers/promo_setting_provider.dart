import 'package:abg_pos_app/app/data/models/PromoSetting.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/alert_snackbar.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/helpers/get_storage_helper.dart';

class PromoSettingProvider extends GetConnect {
  final String url = '/promosettings';
  @override
  void onInit() {
    _providerInit();
  }

  Future<Response<List<PromoSetting>>> getPromoSettings() async {
    final Response response = await get(url);
    if (response.isOk && response.body is List) {
      final List<dynamic> jsonList = response.body;
      final List<PromoSetting> settings = jsonList
          .map((json) => PromoSetting.fromJson(json as Map<String, dynamic>))
          .toList();
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: settings,
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

  Future<Response<Map<String, dynamic>>> updatePromoSetting(
    String id,
    dynamic data,
  ) async {
    Map<String, dynamic> body = {};
    final Response response = await patch('$url/$id', data);
    body['message'] = response.body['message'] as String;
    if (response.isOk) {
      body['promoSetting'] = PromoSetting.fromJson(
        response.body['promoSetting'],
      );
    }
    if (response.hasError && response.body['errors'] != null) {
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

  void _providerInit() {
    httpClient.baseUrl = AppConstants.CURRENT_BASE_API_URL;
    httpClient.timeout = const Duration(seconds: 5);
    httpClient.addRequestModifier<dynamic>((request) {
      BoxHelper box = BoxHelper();
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
