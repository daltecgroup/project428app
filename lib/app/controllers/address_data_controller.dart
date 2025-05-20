import 'package:get/get.dart';
import 'package:project428app/app/data/address_data_provider.dart';

class AddressDataController extends GetxController {
  AddressDataProvider AddressP = AddressDataProvider();
  RxList provinces = [].obs;
  RxList regencies = [].obs;
  RxList districts = [].obs;
  RxList villages = [].obs;

  RxString selectedProvince = ''.obs;
  RxString selectedRegency = ''.obs;
  RxString selectedDistrict = ''.obs;
  RxString selectedVillage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    AddressP.fetchProvinces().then((res) {
      for (var e in res.body) {
        provinces.add(e);
      }
    });
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> fetchRegency(String id) async {
    regencies.clear();
    await AddressP.fetchRegencies(id).then((res) {
      for (var e in res.body) {
        regencies.add(e);
      }
    });
  }

  Future<void> fetchDistrict(String id) async {
    districts.clear();
    await AddressP.fetchDistricts(id).then((res) {
      for (var e in res.body) {
        districts.add(e);
      }
    });
  }

  Future<void> fetchVillage(String id) async {
    villages.clear();
    await AddressP.fetchVillages(id).then((res) {
      for (var e in res.body) {
        villages.add(e);
      }
    });
  }
}
