import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class OutletProvider extends GetConnect {
  AuthService authS = Get.find<AuthService>();
  String accessToken = '';

  Future<Response> getOutlets() async {
    return get(
      '${authS.mainServerUrl.value}/api/v1/outlets',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> getOutletById(String code) async {
    return get(
      '${authS.mainServerUrl.value}/api/v1/outlets/$code',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> createOutlet(
    String code,
    String name,
    bool status,
    Map address,
  ) async {
    final body = json.encode({
      "code": code,
      "name": name,
      "isActive": status,
      "address": address,
    });

    return post(
      '${authS.mainServerUrl.value}/api/v1/outlets/',
      body,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deactivateOutlet(String outlet) async {
    return put(
      '${authS.mainServerUrl.value}/api/v1/outlets/$outlet/deactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> reactivateOutlet(String code) async {
    return put(
      '${authS.mainServerUrl.value}/api/v1/outlets/$code/reactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deleteOutlet(String code) async {
    return delete(
      '${authS.mainServerUrl.value}/api/v1/outlets/$code',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> updateOutlet(String outlet, dynamic data) async {
    return put(
      '${authS.mainServerUrl.value}/api/v1/outlets/$outlet',
      data,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> updateOutletImage(String outlet, File imageFile) async {
    final FormData formData = FormData({
      'image': MultipartFile(
        imageFile,
        filename: 'img-$outlet.${imageFile.path.split('.').last}',
      ),
    });

    return put(
      '${authS.mainServerUrl.value}/api/v1/outlets/$outlet/image',
      formData,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }
}
