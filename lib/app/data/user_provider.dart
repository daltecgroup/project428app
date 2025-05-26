import 'dart:convert';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class UserProvider extends GetConnect {
  AuthService authS = Get.find<AuthService>();
  String accessToken = '';

  Future<Response> getUsers() {
    return get(
      '${authS.mainServerUrl.value}/api/v1/users/',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deleteUser(String id) {
    return delete(
      '${authS.mainServerUrl.value}/api/v1/users/$id',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> activateUser(String id) {
    return put(
      '${authS.mainServerUrl.value}/api/v1/users/$id/reactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deactivateUser(String id) {
    return put(
      '${authS.mainServerUrl.value}/api/v1/users/$id/deactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> createUser(
    String userId,
    String name,
    String pin,
    bool status,
    String phone,
    List role,
  ) {
    final body = json.encode({
      "userId": userId,
      "name": name,
      "pin": pin,
      "isActive": status,
      "phone": phone,
      "role": role,
    });

    return post(
      '${authS.mainServerUrl.value}/api/v1/users/',
      body,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> updateUser(String id, dynamic data) {
    return put(
      '${authS.mainServerUrl.value}/api/v1/users/',
      data,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  @override
  void onInit() {}
}
