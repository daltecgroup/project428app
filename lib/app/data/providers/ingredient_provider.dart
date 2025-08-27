import 'package:abg_pos_app/app/data/models/IngredientHistory.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';
import '../../shared/alert_snackbar.dart';
import '../../utils/constants/app_constants.dart';
import '../../utils/helpers/get_storage_helper.dart';
import '../models/Ingredient.dart';

class IngredientProvider extends GetConnect {
  final String url = '/ingredients';
  @override
  void onInit() {
    _providerInit();
  }

  Future<Response> createIngredient(dynamic data) async {
    Map<String, dynamic> body = {};
    final Response response = await post(url, data);
    body['message'] = response.body['message'] as String;
    if (response.isOk) {
      body['ingredient'] = Ingredient.fromJson(response.body['ingredient']);
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

  Future<Response<List<Ingredient>>> getIngredients() async {
    final Response response = await get(url);
    if (response.isOk && response.body is List) {
      final List<dynamic> jsonList = response.body;
      final List<Ingredient> ingredients = jsonList
          .map((json) => Ingredient.fromJson(json as Map<String, dynamic>))
          .toList();
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: ingredients,
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

  Future<Response<List<IngredientHistory>>> getIngredientHistory(
    String id,
  ) async {
    final Response response = await get('$url/$id/history');
    if (response.isOk && response.body is List) {
      final List<dynamic> jsonList = response.body;
      final List<IngredientHistory> history = jsonList
          .map(
            (json) => IngredientHistory.fromJson(json as Map<String, dynamic>),
          )
          .toList();
      return Response(
        statusCode: response.statusCode,
        statusText: response.statusText,
        body: history,
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

  Future<Response<Map<String, dynamic>>> updateIngredient(
    String id,
    dynamic data,
  ) async {
    Map<String, dynamic> body = {};
    final Response response = await put('$url/$id', data);
    body['message'] = response.body['message'] as String;
    if (response.isOk) {
      body['ingredient'] = Ingredient.fromJson(response.body['ingredient']);
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

  Future<Response<Map<String, dynamic>>> deleteIngredient(String id) async {
    Map<String, dynamic> body = {};
    final Response response = await delete('$url/$id');
    body['message'] = response.body['message'] as String;
    if (response.isOk) {
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
