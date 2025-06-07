import 'package:get/get.dart';
import '../../services/auth_service.dart';

class OperatorProvider extends GetConnect {
  AuthService authS = Get.find<AuthService>();
  String accessToken = '';
  @override
  void onInit() {}

  Future<Response> getOperatorOutletById(String id) {
    return get(
      '${authS.mainServerUrl.value}/api/v1/operator/$id/outlet',
      headers: {"Authorization": "Bearer $accessToken"},
    );
  }
}
