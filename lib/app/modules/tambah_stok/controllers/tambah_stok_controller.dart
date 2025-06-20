import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/data/providers/stock_provider.dart';
import 'package:project428app/app/core/constants/error_code.dart';

import '../../../core/constants/constants.dart';
import '../../../services/stock_service.dart';

class TambahStokController extends GetxController {
  StockService StockS = Get.find<StockService>();
  GetStorage box = GetStorage();
  late TextEditingController stockIdC;
  late TextEditingController nameC;
  late TextEditingController priceC;

  StockProvider Stock = StockProvider();

  RxString unit = 'weight'.obs;
  RxDouble price = 0.0.obs;

  RxBool isStockIdError = false.obs;
  RxBool isNameError = false.obs;
  RxBool isPriceError = false.obs;

  RxString stockIdErrorText = 'Kode Stok tidak boleh kosong'.obs;

  RxBool isLoading = false.obs;

  void createStock() async {
    isLoading.value = true;
    checkError();

    if (isStockIdError.isFalse && isNameError.isFalse && isPriceError.isFalse) {
      try {
        await Stock.createStock(
          box.read('userProfile')['id'],
          stockIdC.text.trim().toUpperCase(),
          nameC.text.trim().capitalize!,
          unit.value,
          price.value.toInt(),
        ).then((res) async {
          print('res body: ${res.body}');
          switch (res.statusCode) {
            case 201:
              Get.snackbar("Berhasil", 'Stok ${nameC.text} berhasil dibuat.');
              StockS.getStocks();
              Get.offNamed('/stok');
              break;
            case 400:
              if (res.body['errorCode'] == ErrorCode.stockAlreadyExist) {
                isStockIdError.value = true;
                stockIdErrorText.value = res.body['message'];
              } else {
                Get.snackbar(kTitleFailed, res.body['errorCode']);
              }
              break;
            default:
              Get.defaultDialog(
                title: kTitleFailed,
                content: Text(res.statusText.toString()),
              );
          }
        });
      } catch (e) {
        print(e);
      }
    } else {
      isLoading.value = false;
    }
  }

  void checkError() {
    if (stockIdC.text.isEmpty) {
      isStockIdError.value = true;
      stockIdErrorText.value = 'Kode Stok tidak boleh kosong';
    }
    if (nameC.text.isEmpty) {
      isNameError.value = true;
    }
    if (priceC.text.isEmpty || int.parse(priceC.text) == 0) {
      isPriceError.value = true;
    }
  }

  void resetError() {
    isStockIdError.value = false;
    isNameError.value = false;
    isPriceError.value = false;
    isLoading.value = false;
  }

  void resetField() {
    unit.value = 'weight';
    price.value = 0.0;
    stockIdC.clear();
    nameC.clear();
    priceC.clear();

    resetError();
  }

  @override
  void onInit() {
    super.onInit();
    stockIdC = TextEditingController();
    nameC = TextEditingController();
    priceC = TextEditingController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
    stockIdC.dispose();
    nameC.dispose();
    priceC.dispose();
  }
}
