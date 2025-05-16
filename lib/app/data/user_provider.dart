import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';

class UserProvider extends GetConnect {
  GetStorage box = GetStorage();
  String accessToken = '';

  Future<Response> loginUser(String userId, String pin) {
    final data = json.encode({"userId": userId, "pin": pin});
    return post('$kServerUrl/api/v1/auth/login', data);
  }

  Future<Response> getUsers() {
    return get(
      '$kServerUrl/api/v1/users/',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deleteUser(String id) {
    return delete(
      '$kServerUrl/api/v1/users/$id',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> activateUser(String id) {
    return patch(
      '$kServerUrl/api/v1/users/$id/reactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deactivateUser(String id) {
    return patch(
      '$kServerUrl/api/v1/users/$id/deactivate',
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
      '$kServerUrl/api/v1/users/',
      body,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  @override
  void onInit() {
    if (box.read(kUserData) != null) {
      accessToken = box.read(kUserData)['accessToken'];
    }
  }
}
