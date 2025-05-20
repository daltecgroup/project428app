import 'package:get/get.dart';

class AddressDataProvider extends GetConnect {
  String url = 'https://www.emsifa.com/api-wilayah-indonesia/api/';

  Future<Response> fetchProvinces() {
    return get('${url}provinces.json');
  }

  Future<Response> fetchRegencies(String id) {
    return get('${url}regencies/$id.json');
  }

  Future<Response> fetchDistricts(String id) {
    return get('${url}districts/$id.json');
  }

  Future<Response> fetchVillages(String id) {
    return get('${url}villages/$id.json');
  }
}
