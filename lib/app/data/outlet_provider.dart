import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import '../constants.dart';

class OutletProvider extends GetConnect {
  String accessToken = '';
  String url = '$kServerUrl/api/v1/outlets';
  @override
  void onInit() {}

  Future<Response> getOutlets() {
    return get('$url/', headers: {"Authorization": "Bearer $accessToken"});
  }

  Future<Response> getOutletById(String code) {
    return get('$url/$code', headers: {"Authorization": "Bearer $accessToken"});
  }

  Future<Response> createOutlet(
    String code,
    String name,
    bool status,
    Map address,
  ) {
    final body = json.encode({
      "code": code,
      "name": name,
      "isActive": status,
      "address": address,
    });

    return post(
      '$url/',
      body,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deactivateOutlet(String outlet) {
    return patch(
      '$url/$outlet/deactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> reactivateOutlet(String code) {
    return patch(
      '$url/$code/reactivate',
      {},
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> deleteOutlet(String code) {
    return delete(
      '$url/$code',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> updateOutlet(String outlet, dynamic data) {
    return put(
      '$url/$outlet',
      data,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }

  Future<Response> updateOutletImage(String outlet, File imageFile) {
    final FormData formData = FormData({
      'image': MultipartFile(
        imageFile,
        filename: 'img-$outlet.${imageFile.path.split('.').last}',
      ),
    });

    return put(
      '$url/$outlet/image',
      formData,
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }
}
