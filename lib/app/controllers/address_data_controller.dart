import 'package:get/get.dart';
import '../data/providers/address_data_provider.dart';

class AddressDataController extends GetxController {
  AddressDataProvider provider = Get.put(AddressDataProvider());
  RxList provinces = [].obs;
  RxList regencies = [].obs;
  RxList districts = [].obs;
  RxList villages = [].obs;

  RxString selectedProvince = ''.obs;
  RxString selectedRegency = ''.obs;
  RxString selectedDistrict = ''.obs;
  RxString selectedVillage = ''.obs;

  RxMap addressMap = {}.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await initProvinceData();
  }

  void setProvince(String id) {
    addressMap['province'] = provinces.firstWhere((e) => e['id'] == id)['nama'];
  }

  void setRegency(String id) {
    addressMap['regency'] = regencies.firstWhere((e) => e['id'] == id)['nama'];
  }

  void setDistrict(String id) {
    addressMap['district'] = districts.firstWhere((e) => e['id'] == id)['nama'];
  }

  void setVillage(String id) {
    addressMap['village'] = villages.firstWhere((e) => e['id'] == id)['nama'];
  }

  Future<void> initProvinceData() async {
    provinces.clear();
    await provider.fetchProvinces().then((res) {
      for (var e in res.body) {
        provinces.add(e);
      }
    });
    selectedProvince.value = provinces.first['id'];
    addressMap['province'] = provinces.first['nama'];
  }

  Future<void> fetchRegency(String id) async {
    regencies.clear();
    await provider.fetchRegencies(id).then((res) {
      for (var e in res.body) {
        regencies.add(e);
      }
    });
    selectedRegency.value = regencies.first['id'];
    addressMap['regency'] = provinces.first['nama'];
  }

  Future<void> fetchDistrict(String id) async {
    districts.clear();
    await provider.fetchDistricts(id).then((res) {
      for (var e in res.body) {
        districts.add(e);
      }
    });
    selectedDistrict.value = districts.first['id'];
    addressMap['district'] = provinces.first['nama'];
  }

  Future<void> fetchVillage(String id) async {
    villages.clear();
    await provider.fetchVillages(id).then((res) {
      for (var e in res.body) {
        villages.add(e);
      }
    });
    selectedVillage.value = villages.first['id'];
    addressMap['village'] = provinces.first['nama'];
  }
}
