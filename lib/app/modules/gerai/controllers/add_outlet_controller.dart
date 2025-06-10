import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project428app/app/controllers/address_data_controller.dart';
import 'package:project428app/app/data/providers/outlet_provider.dart';
import 'package:project428app/app/modules/gerai/controllers/gerai_controller.dart';
import 'package:project428app/app/services/outlet_service.dart';

class AddOutletController extends GetxController {
  AddressDataController addressC = Get.find<AddressDataController>(
    tag: 'add_outlet',
  );
  GeraiController geraiC = Get.find<GeraiController>();

  OutletProvider OutletP = OutletProvider();
  OutletService OutletS = OutletService();
  RxBool isLoading = false.obs;

  late TextEditingController codeC;
  late TextEditingController nameC;
  late TextEditingController streetC;

  RxBool status = true.obs;

  RxBool isCodeError = false.obs;
  RxBool isNameError = false.obs;

  RxBool isProvinceError = false.obs;
  RxBool isRegencyError = false.obs;
  RxBool isDistrictError = false.obs;
  RxBool isVillageError = false.obs;
  RxBool isStreetError = false.obs;

  RxString codeErrorText = 'Kode harus diisi'.obs;

  @override
  void onInit() {
    codeC = TextEditingController();
    nameC = TextEditingController();
    streetC = TextEditingController();
    super.onInit();
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

  void createOutlet() {
    isLoading.value = true;
    Get.defaultDialog(
      title: 'Sedang menyimpan...',
      titleStyle: TextStyle(fontSize: 16),
      content: LinearProgressIndicator(),
      radius: 12,
    );

    Map address = {
      'province': addressC.selectedProvince.value.toLowerCase().capitalize,
      'regency': addressC.selectedRegency.value.toLowerCase().capitalize,
      'district': addressC.selectedDistrict.value.toLowerCase().capitalize,
      'village': addressC.selectedVillage.value.toLowerCase().capitalize,
      'street': streetC.text.trim().capitalizeFirst!,
    };

    try {
      OutletP.createOutlet(
        codeC.text.trim().capitalize!,
        nameC.text.trim().capitalize!,
        status.value,
        address,
      ).then((res) {
        Get.back();
        switch (res.statusCode) {
          case 201:
            OutletS.getOutlets();
            Get.back();
            break;
          case 400:
            Get.defaultDialog(
              title: 'Penyimpanan Gagal',
              titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              content: Text(res.body['message']),
              radius: 12,
            );
            break;
          default:
            Get.defaultDialog(
              title: 'Penyimpanan Gagal',
              titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              content: Text('Gagal tersambung dengan server'),
              radius: 12,
            );
        }
      });
      isLoading.value = false;
    } catch (e) {
      print(e);
      isLoading.value = false;
      Get.back();
    }
  }

  void errorCheck() {
    var error = false;
    List errorList = [];

    if (codeC.text.isEmpty) {
      isCodeError.value = true;
      error = true;
      errorList.add('Kode harus diisi');
    } else {
      isCodeError.value = false;
    }

    if (nameC.text.isEmpty) {
      isNameError.value = true;
      error = true;
      errorList.add('Nama harus diisi');
    } else {
      isNameError.value = false;
    }

    if (addressC.selectedProvince.isEmpty) {
      isProvinceError.value = true;
      error = true;
      errorList.add('Provinsi harus dipilih');
    } else {
      isProvinceError.value = false;
    }

    if (addressC.selectedRegency.isEmpty) {
      isRegencyError.value = true;
      error = true;
      errorList.add('Kabupaten/kota harus dipilih');
    } else {
      isRegencyError.value = false;
    }

    if (addressC.selectedDistrict.isEmpty) {
      isDistrictError.value = true;
      error = true;
      errorList.add('Kecamatan harus dipilih');
    } else {
      isDistrictError.value = false;
    }

    if (addressC.selectedVillage.isEmpty) {
      isVillageError.value = true;
      error = true;
      errorList.add('Kelurahan harus dipilih');
    } else {
      isVillageError.value = false;
    }

    if (streetC.text.isEmpty) {
      isStreetError.value = true;
      error = true;
      errorList.add('Nama jalan harus diisi');
    } else {
      isStreetError.value = false;
    }

    if (error) {
      Get.defaultDialog(
        title: 'Penyimpanan Gagal',
        titleStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...List.generate(
              errorList.length,
              (index) => Text(
                '- ${errorList[index]}',
                style: TextStyle(color: Colors.red),
              ),
            ),
          ],
        ),
        radius: 12,
      );
    } else {
      createOutlet();
    }
  }
}
