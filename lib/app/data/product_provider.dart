import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import '../constants.dart';

class ProductProvider extends GetConnect {
  String accessToken = '';
  String url = '$kServerUrl/api/v1/products';
  @override
  void onInit() {
    httpClient.baseUrl = url;
  }

  Future<Response> getProducts() {
    return get('$url/', headers: {"Authorization": "Bearer $accessToken"});
  }

  Future<Response> getProductById(String code) {
    return get('$url/$code', headers: {"Authorization": "Bearer $accessToken"});
  }

  Future<Response> createProduct(
    File imageFile,
    String code,
    bool isActive,
    String name,
    int price,
    int discount,
    String category,
    String description,
    List ingredients,
  ) {
    // create json string from all that data except image
    final String jsonString = jsonEncode({
      'code': code,
      'is_active': isActive,
      'name': name,
      'category': category,
      'price': price,
      'discount': discount,
      'description': description,
      'ingredients': ingredients,
    });

    final FormData formData = FormData({
      'product': jsonString,
      'image': MultipartFile(
        imageFile,
        filename: 'img-$code.${imageFile.path.split('.').last}',
      ),
    });

    return post(
      '$url/',
      formData,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }
}
