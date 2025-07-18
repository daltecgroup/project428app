import 'dart:convert';

import 'package:abg_pos_app/app/utils/helpers/data_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/bundle_data_controller.dart';
import '../../../../controllers/menu_category_data_controller.dart';
import '../../../../data/models/BundleCategory.dart';
import '../../../../routes/app_pages.dart';

class BundleInputController extends GetxController {
  BundleInputController({required this.data, required this.categoryData});

  final BundleDataController data;
  final MenuCategoryDataController categoryData;
  final String backRoute = Get.previousRoute;
  RxList<BundleCategory> categoryList = <BundleCategory>[].obs;

  // text controllers
  TextEditingController nameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

  // error boolean
  RxBool nameError = false.obs;
  RxBool priceError = false.obs;
  RxBool descriptionError = false.obs;
  RxBool categoryError = false.obs;

  // error text
  RxString nameErrorText = ''.obs;
  RxString priceErrorText = ''.obs;
  RxString descriptionErrorText = ''.obs;
  RxString categoryErrorText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setEditData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    nameC.dispose();
    priceC.dispose();
    descriptionC.dispose();
    super.onClose();
  }

  bool get isEdit => data.selectedBundle.value != null;

  void setEditData() {
    final bundle = data.selectedBundle.value;
    if (bundle == null) return clearField();
    if (isEdit) {
      nameC.text = bundle.name;
      priceC.text = bundle.price.round().toString();
      descriptionC.text = bundle.description ?? '';
      categoryList.value = bundle.categories;
    }
  }

  void clearField() {
    nameC.clear();
    priceC.clear();
    descriptionC.clear();
    categoryList.clear();
  }

  Future<void> addCategory() async {
    categoryList.value =
        await Get.toNamed(Routes.SELECT_MENU_CATEGORY, arguments: categoryList)
            as List<BundleCategory>;
  }

  bool get isError {
    nameError.value = nameC.text.isEmpty || nameC.text.length < 3;
    nameErrorText.value = nameC.text.isEmpty
        ? 'Nama paket tidak boleh kosong'
        : nameC.text.length < 3
        ? 'Nama terlalu pendek'
        : '';

    priceError.value = priceC.text.isEmpty || !GetUtils.isNum(priceC.text);
    priceErrorText.value = priceC.text.isEmpty
        ? 'Harga paket tidak boleh kosong'
        : !GetUtils.isNum(priceC.text)
        ? 'Harga harus dalam angka'
        : '';

    descriptionError.value =
        descriptionC.text.isEmpty || descriptionC.text.length < 3;
    descriptionErrorText.value = descriptionC.text.isEmpty
        ? 'Deskripsi paket tidak boleh kosong'
        : descriptionC.text.length < 3
        ? 'Deskripsi terlalu pendek'
        : '';

    return nameError.value || priceError.value || descriptionError.value;
  }

  bool get isChange {
    return data.selectedBundle.value!.name.toLowerCase() !=
            nameC.text.trim().toLowerCase() ||
        data.selectedBundle.value!.price != double.parse(priceC.text.trim()) ||
        !isSameBundleCategoryList(
          categoryList,
          data.selectedBundle.value!.categories,
        );
  }

  Future<void> submit() async {
    final Map rawData = {};
    rawData['name'] = nameC.text.trim().toLowerCase();
    rawData['price'] = double.parse(priceC.text.trim());
    rawData['description'] = descriptionC.text.trim();
    if (categoryList.isNotEmpty) {
      rawData['categories'] = categoryList
          .map((e) => {'menuCategoryId': e.menuCategoryId, 'qty': e.qty})
          .toList();
    } else {
      rawData['categories'] = [];
    }
    if (!isError) {
      if (isEdit) {
        // submit edit
        await data.updateBundle(
          id: data.selectedBundle.value!.id,
          data: json.encode(rawData),
          backRoute: backRoute,
        );
      } else {
        await data.createBundle(json.encode(rawData));
      }
    }
  }
}
