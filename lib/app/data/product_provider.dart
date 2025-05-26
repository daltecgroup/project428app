import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import '../services/auth_service.dart';

class ProductProvider extends GetConnect {
  AuthService authS = Get.find<AuthService>();
  String accessToken = '';

  @override
  void onInit() {}

  Future<Response> getProducts() {
    return get(
      '${authS.mainServerUrl.value}/api/v1/products/',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> getProductById(String code) {
    return get(
      '${authS.mainServerUrl.value}/api/v1/products/$code',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deleteProduct(String code) {
    return delete(
      '${authS.mainServerUrl.value}/api/v1/products/$code',
      headers: {"Authorization": "Bearer $accessToken"},
    );
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
      '${authS.mainServerUrl.value}/api/v1/products/',
      formData,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }
}
