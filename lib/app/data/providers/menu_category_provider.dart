import 'package:get/get.dart';
import '../../routes/app_pages.dart';
import '../../shared/alert_snackbar.dart';
import '../../data/models/MenuCategory.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/helpers/get_storage_helper.dart';

class MenuCategoryProvider extends GetConnect {
  final String url = '/menucategories';
  @override
  void onInit() {
    _providerInit();
  }

  Future<Response<Map<String, dynamic>>> createMenuCategory(
    dynamic data,
  ) async {
    Map<String, dynamic> body = {};
    final Response response = await post(url, data);
    body['message'] = response.body['message'] as String;
    if (response.isOk) {
      body['menuCategory'] = MenuCategory.fromJson(
        response.body['menuCategory'],
      );
    }
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

  Future<Response<List<MenuCategory>>> getMenuCategories() async {
    final Response response = await get(url);
    if (response.isOk && response.body is List) {
      final List<dynamic> jsonList = response.body;
      final List<MenuCategory> categories = jsonList
          .map((json) => MenuCategory.fromJson(json as Map<String, dynamic>))
          .toList();
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: categories,
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

  Future<Response<Map<String, dynamic>>> updateMenuCategory(
    String id,
    dynamic data,
  ) async {
    Map<String, dynamic> body = {};
    final Response response = await put('$url/$id', data);
    body['message'] = response.body['message'] as String;
    if (response.isOk) {
      body['menuCategory'] = MenuCategory.fromJson(
        response.body['menuCategory'],
      );
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: body,
        headers: response.headers,
        request: response.request,
      );
    } else {
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: body,
        headers: response.headers,
        request: response.request,
      );
    }
  }

  Future<Response<Map<String, dynamic>>> deleteMenuCategory(String id) async {
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
