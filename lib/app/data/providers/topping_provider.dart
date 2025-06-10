import 'package:get/get.dart';

import '../../services/auth_service.dart';

class ToppingProvider extends GetConnect {
  AuthService authS = Get.find<AuthService>();
  String accessToken = '';
  @override
  void onInit() {
    // httpClient.baseUrl = 'YOUR-API-URL';
    print('topping provider init');
  }

  Future<Response> createTopping(dynamic data) {
    return post(
      '${authS.mainServerUrl.value}/api/v1/toppings/',
      data,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> getAllToppings() {
    return get(
      '${authS.mainServerUrl.value}/api/v1/toppings/',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> updateToppingById(String id, dynamic data) {
    return put(
      '${authS.mainServerUrl.value}/api/v1/toppings/$id',
      data,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }
}
