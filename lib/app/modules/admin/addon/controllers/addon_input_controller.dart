import 'dart:convert';
import 'package:abg_pos_app/app/utils/helpers/data_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../controllers/addon_data_controller.dart';
import '../../../../data/models/Recipe.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/helpers/text_helper.dart';

class AddonInputController extends GetxController {
  AddonInputController({required this.data});
  AddonDataController data;
  final String backRoute = Get.previousRoute;

  RxList<Recipe> recipeList = <Recipe>[].obs;

  // text controllers
  TextEditingController nameC = TextEditingController();
  TextEditingController priceC = TextEditingController();

  // error boolean
  RxBool nameError = false.obs;
  RxBool priceError = false.obs;

  // error text
  RxString nameErrorText = ''.obs;
  RxString priceErrorText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setEditData();
  }

  @override
  void onClose() {
    nameC.dispose();
    priceC.dispose();
    super.onClose();
  }

  bool get isEdit => data.selectedAddon.value != null;

  void setEditData() {
    if (isEdit) {
      nameC.text = normalizeName(data.selectedAddon.value!.name);
      priceC.text = normalizeName(
        data.selectedAddon.value!.price.round().toString(),
      );
      recipeList.value = data.selectedAddon.value!.recipe;
      nameError.value = false;
      priceError.value = false;
    } else {
      clearField();
    }
  }

  Future<List<Recipe>> selectIngredients() async {
    List<Recipe> result = await Get.toNamed(
      Routes.SELECT_INGREDIENT,
      arguments: recipeList,
    );
    return result;
  }

  Future<void> addIngredients() async {
    recipeList.value = await selectIngredients();
  }

  bool get isError {
    nameError.value = nameC.text.isEmpty || nameC.text.length < 3;
    nameErrorText.value = nameC.text.isEmpty
        ? 'Nama Add-on tidak boleh kosong'
        : nameC.text.length < 3
        ? 'Nama terlalu pendek'
        : '';

    priceError.value = priceC.text.isEmpty || !GetUtils.isNum(priceC.text);
    priceErrorText.value = priceC.text.isEmpty
        ? 'Harga add-on tidak boleh kosong'
        : !GetUtils.isNum(priceC.text)
        ? 'Harga harus dalam angka'
        : '';

    return nameError.value || priceError.value;
  }

  bool get isChange {
    return data.selectedAddon.value!.name.toLowerCase() !=
            nameC.text.trim().toLowerCase() ||
        data.selectedAddon.value!.price != double.parse(priceC.text.trim()) ||
        !isSameRecipeList(recipeList, data.selectedAddon.value!.recipe);
  }

  Future<void> submit() async {
    if (!isError) {
      final rawData = json.encode({
        'name': nameC.text.toLowerCase(),
        'price': double.parse(priceC.text),
        'recipe': recipeList
            .map((e) => {'ingredientId': e.ingredient.id, 'qty': e.qty})
            .toList(),
      });
      if (isEdit) {
        if (!isChange) {
          Get.offNamed(backRoute);
        } else {
          var jsonData = json.encode({
            'name': nameC.text.trim().toLowerCase(),
            'price': double.parse(priceC.text.trim()),
            'recipe': recipeList
                .map((e) => {'ingredientId': e.ingredient.id, 'qty': e.qty})
                .toList(),
          });
          await data.updateAddon(
            id: data.selectedAddon.value!.id,
            data: jsonData,
            backRoute: backRoute,
          );
        }
      } else {
        data.createAddon(rawData);
      }
    }
  }

  void clearField() {
    nameC.clear();
    priceC.clear();
  }
}
