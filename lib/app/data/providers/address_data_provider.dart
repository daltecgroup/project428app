import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:get/get.dart';

class AddressDataProvider extends GetConnect {
  String url = '${AppConstants.CURRENT_BASE_API_URL}/address';

  Future<Response> fetchProvinces() {
    return get('$url/provinces');
  }

  Future<Response> fetchRegencies(String id) {
    return get('$url/regencies/$id');
  }

  Future<Response> fetchDistricts(String id) {
    return get('$url/districts/$id');
  }

  Future<Response> fetchVillages(String id) {
    return get('$url/villages/$id');
  }

  Future<Response> getAddressById(String id) {
    return get('$url/$id');
  }
}
