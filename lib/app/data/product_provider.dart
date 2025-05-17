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
}
