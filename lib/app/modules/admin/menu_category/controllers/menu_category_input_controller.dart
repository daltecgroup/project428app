import 'dart:convert';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../utils/helpers/text_helper.dart';

class MenuCategoryInputController extends GetxController {
  MenuCategoryInputController({required this.data});
  MenuCategoryDataController data;
  final String backRoute = Get.previousRoute;

  // text controllers
  late TextEditingController nameC;

  // error boolean
  RxBool nameError = false.obs;

  // error text
  RxString nameErrorText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    nameC = TextEditingController();
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
  }

  bool get isEdit => data.selectedMenuCategory.value != null;

  void setEditData() {
    if (isEdit) {
      nameC.text = normalizeName(data.selectedMenuCategory.value!.name);
      return;
    }
    clearField();
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

    return error;
  }

  Future<void> submit() async {
    if (!isError) {
      final rawData = json.encode({'name': nameC.text.toLowerCase()});
      if (isEdit) {
        if (data.selectedMenuCategory.value!.name.toLowerCase() ==
            nameC.text.trim().toLowerCase()) {
          Get.offNamed(backRoute);
        } else {
          await data.updateMenuCategory(
            id: data.selectedMenuCategory.value!.id,
            data: json.encode({'name': nameC.text.trim().toLowerCase()}),
            backRoute: backRoute,
          );
        }
      } else {
        data.createMenuCategory(rawData);
      }
    }
  }

  void clearField() {
    nameC.clear();
  }
}
