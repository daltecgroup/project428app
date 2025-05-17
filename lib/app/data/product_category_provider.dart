import 'dart:convert';

import 'package:get/get.dart';

import '../constants.dart';

class ProductCategoryProvider extends GetConnect {
  String accessToken = '';
  String url = '$kServerUrl/api/v1/product-categories';
  @override
  void onInit() {
    httpClient.baseUrl = url;
  }

  Future<Response> getProductCategories() {
    return get('$url/', headers: {"Authorization": "Bearer $accessToken"});
  }

  Future<Response> getProductCategoryById(String id) {
    return get('$url/$id', headers: {"Authorization": "Bearer $accessToken"});
  }

  Future<Response> createProductCategory(String name) {
    final body = json.encode({"name": name});

    return post(
      '$url/',
      body,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deactivateProductCategory(String id) {
    return patch(
      '$url/$id/deactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> reactivateProductCategory(String id) {
    return patch(
      '$url/$id/reactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deleteProductCategory(String id) {
    return delete(
      '$url/$id',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> updateProductCategory(String id, String name) {
    final body = json.encode({"name": name});
    return put(
      '$url/$id',
      body,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }
}
