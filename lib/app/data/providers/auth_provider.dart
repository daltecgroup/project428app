import 'dart:convert';

import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:get/get.dart';

class AuthProvider extends GetConnect {
  @override
  void onInit() {
    httpClient.baseUrl = AppConstants.CURRENT_BASE_API_URL;
    httpClient.timeout = const Duration(seconds: 5);
  }

  Future<Response> login(String id, String password) {
    var data = json.encode({'userId': id, 'password': password});
    return post('/auth/login', data);
  }
}
