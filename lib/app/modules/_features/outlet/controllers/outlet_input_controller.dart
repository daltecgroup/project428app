import '../../../../controllers/address_data_controller.dart';
import '../../../../controllers/outlet_data_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OutletInputController extends GetxController {
  OutletInputController({required this.data});
  OutletDataController data;

  AddressDataController address = Get.put(AddressDataController());

  final String backRoute = Get.previousRoute;

  // text controllers
  TextEditingController codeC = TextEditingController();
  TextEditingController nameC = TextEditingController();
  TextEditingController streetC = TextEditingController();

  // error boolean
  RxBool codeError = false.obs;
  RxBool nameError = false.obs;
  RxBool addressError = false.obs;

  // error text
  RxString codeErrorText = ''.obs;
  RxString nameErrorText = ''.obs;
  RxString addressErrorText = ''.obs;

  RxBool updateAddress = false.obs;

  @override
  void onInit() {
    super.onInit();
    initInput();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    codeC.dispose();
    nameC.dispose();
    streetC.dispose();
    super.onClose();
  }

  bool get isEdit => data.selectedOutlet.value != null;

  void initInput() {
    if (isEdit) {
      final outlet = data.selectedOutlet.value!;
      updateAddress.value = false;
      codeC.text = outlet.code;
      nameC.text = outlet.name;
      address.regencies.clear();
      address.districts.clear();
      address.villages.clear();
      streetC.clear();
    } else {
      updateAddress.value = true;
      clearField();
    }
  }

  bool get isError {
    nameError.value = nameC.text.isEmpty || nameC.text.length < 3;
    nameErrorText.value = nameC.text.isEmpty
        ? 'Nama menu tidak boleh kosong'
        : nameC.text.length < 3
        ? 'Nama terlalu pendek'
        : '';

    if (address.selectedRegency.isEmpty ||
        address.selectedDistrict.isEmpty ||
        address.selectedVillage.isEmpty ||
        streetC.text.isEmpty) {
      addressError.value = true;
      addressErrorText.value = 'Alamat belum lengkap terisi.';
    } else {
      addressError.value = false;
    }

    if (!updateAddress.value) addressError.value = false;

    return nameError.value || codeError.value || addressError.value;
  }

  bool get isChange {
    final outlet = data.selectedOutlet.value!;

    return outlet.code != codeC.text ||
        outlet.name != nameC.text ||
        updateAddress.value;
  }

  Future<void> submit() async {
    if (!isError) {
      final rawData = {};
      if (codeC.text.isNotEmpty) {
        rawData['code'] = codeC.text.trim().toUpperCase();
      }

      rawData['name'] = nameC.text.trim();

      if (updateAddress.value) {
        address.addressMap['street'] = streetC.text.trim();
        rawData['address'] = address.addressMap;
      }

      if (isEdit) {
        if (!isChange) {
          Get.back();
        } else {
          await data.updateOutlet(
            id: data.selectedOutlet.value!.id,
            data: rawData,
            backRoute: backRoute,
          );
        }
      } else {
        data.createOutlet(rawData);
      }
    }
  }

  void clearField() {
    codeC.clear();
    nameC.clear();
    streetC.clear();
  }
}
