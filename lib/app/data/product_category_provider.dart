import 'dart:convert';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class ProductCategoryProvider extends GetConnect {
  AuthService authS = Get.find<AuthService>();
  String accessToken = '';

  @override
  void onInit() {}

  Future<Response> getProductCategories() {
    return get(
      '${authS.mainServerUrl.value}/api/v1/product-categories/',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> getProductCategoryById(String id) {
    return get(
      '${authS.mainServerUrl.value}/api/v1/product-categories/$id',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> createProductCategory(String name) {
    final body = json.encode({"name": name});

    return post(
      '${authS.mainServerUrl.value}/api/v1/product-categories/',
      body,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deactivateProductCategory(String id) {
    return put(
      '${authS.mainServerUrl.value}/api/v1/product-categories/$id/deactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> reactivateProductCategory(String id) {
    return put(
      '${authS.mainServerUrl.value}/api/v1/product-categories/$id/reactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deleteProductCategory(String id) {
    return delete(
      '${authS.mainServerUrl.value}/api/v1/product-categories/$id',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> updateProductCategory(String id, String name) {
    final body = json.encode({"name": name});
    return put(
      '${authS.mainServerUrl.value}/api/v1/product-categories/$id',
      body,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }
}
