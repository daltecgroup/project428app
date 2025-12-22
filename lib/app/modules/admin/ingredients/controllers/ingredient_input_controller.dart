import 'dart:convert';

import 'package:abg_pos_app/app/utils/helpers/text_helper.dart';
import 'package:abg_pos_app/app/utils/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/ingredient_data_controller.dart';
import '../../../../routes/app_pages.dart';

class IngredientInputController extends GetxController {
  IngredientInputController({required this.data});
  IngredientDataController data;
  AuthService auth = Get.find<AuthService>();
  final String backRoute = Get.previousRoute;

  // text controllers
  final TextEditingController nameC = TextEditingController();
  final TextEditingController priceC =TextEditingController();

  // error boolean
  RxBool nameError = false.obs;
  RxBool priceError = false.obs;

  // error text
  RxString nameErrorText = ''.obs;
  RxString priceErrorText = ''.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    setEditData();
  }

  @override
  void onClose() {
    super.onClose();
    nameC.dispose();
    priceC.dispose();
  }

  bool get isEdit => data.selectedIngredient.value != null;

  void setEditData() {
    if (isEdit) {
      nameC.text = normalizeName(data.selectedIngredient.value!.name);
      priceC.text = data.selectedIngredient.value!.priceString;
    }
  }

  bool get isError {
    bool error = false;

    if (nameC.text.isEmpty) {
      error = true;
      nameError.value = true;
      nameErrorText.value = 'Nama bahan tidak boleh kosong';
    } else if (nameC.text.length < 3) {
      error = true;
      nameError.value = true;
      nameErrorText.value = 'Nama terlalu pendek';
    }

    if (priceC.text.isEmpty) {
      error = true;
      priceError.value = true;
      priceErrorText.value = 'Harga bahan tidak boleh kosong';
    } else if (!GetUtils.isNum(priceC.text)) {
      error = true;
      priceError.value = true;
      priceErrorText.value = 'Harga harus dalam angka';
    }

    return error;
  }

  void submit() {
    if (!isError) {
      final rawData = json.encode({
        'name': nameC.text.toLowerCase(),
        'price': double.parse(priceC.text),
      });
      if (isEdit) {
        data.updateIngredient(
          data: rawData,
          backRoute: Routes.INGREDIENT_DETAIL,
        );
      } else {
        data.createIngredient(rawData);
      }
    }
  }

  void clearField() {
    nameC.clear();
    priceC.clear();
  }
}
