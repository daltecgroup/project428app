import 'package:get/get.dart';

import '../constants.dart';

class OperatorProvider extends GetConnect {
  String accessToken = '';
  String url = '$kServerUrl/api/v1/operator';
  @override
  void onInit() {}

  Future<Response> getOperatorOutletById(String id) {
    return get(
      '$url/$id/outlet',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }
}
