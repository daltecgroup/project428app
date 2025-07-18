import 'dart:convert';

import 'package:abg_pos_app/app/controllers/ingredient_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_category_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_data_controller.dart';
import 'package:abg_pos_app/app/utils/helpers/number_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../data/models/Recipe.dart';
import '../../../../routes/app_pages.dart';
import '../../../../utils/helpers/data_helper.dart';
import '../../../../utils/helpers/text_helper.dart';

class MenuInputController extends GetxController {
  MenuInputController({
    required this.data,
    required this.ingredientData,
    required this.categoryData,
  });

  MenuDataController data;
  IngredientDataController ingredientData;
  MenuCategoryDataController categoryData;

  final String backRoute = Get.previousRoute;

  RxList<Recipe> recipeList = <Recipe>[].obs;

  // text controllers
  TextEditingController nameC = TextEditingController();
  TextEditingController priceC = TextEditingController();
  TextEditingController discountC = TextEditingController();
  TextEditingController descriptionC = TextEditingController();

  // selected category
  RxString selectedCategory = ''.obs;

  // error boolean
  RxBool nameError = false.obs;
  RxBool priceError = false.obs;
  RxBool discountError = false.obs;
  RxBool descriptionError = false.obs;

  // error text
  RxString nameErrorText = ''.obs;
  RxString priceErrorText = ''.obs;
  RxString discountErrorText = ''.obs;
  RxString descriptionErrorText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    setEditData();
  }

  @override
  void onClose() {
    nameC.dispose();
    priceC.dispose();
    discountC.dispose();
    descriptionC.dispose();
    super.onClose();
  }

  bool get isEdit => data.selectedMenu.value != null;

  void setEditData() {
    categoryData.syncData(refresh: true);
    selectedCategory.value = categoryData.categories.first.id;
    if (isEdit) {
      nameC.text = normalizeName(data.selectedMenu.value!.name);
      priceC.text = normalizeName(
        data.selectedMenu.value!.price.round().toString(),
      );
      discountC.text = inLocalNumber(data.selectedMenu.value!.discount);
      recipeList.value = ingredientData.getRecipeFromRawRecipe(
        data.selectedMenu.value!.recipe,
      );
      descriptionC.text = data.selectedMenu.value!.description;
      nameError.value = false;
      priceError.value = false;
      discountError.value = false;
    } else {
      clearField();
    }
  }

  Future<void> addIngredients() async {
    recipeList.value =
        await Get.toNamed(Routes.SELECT_INGREDIENT, arguments: recipeList)
            as List<Recipe>;
  }

  bool get isError {
    nameError.value = nameC.text.isEmpty || nameC.text.length < 3;
    nameErrorText.value = nameC.text.isEmpty
        ? 'Nama menu tidak boleh kosong'
        : nameC.text.length < 3
        ? 'Nama terlalu pendek'
        : '';

    priceError.value = priceC.text.isEmpty || !GetUtils.isNum(priceC.text);
    priceErrorText.value = priceC.text.isEmpty
        ? 'Harga menu tidak boleh kosong'
        : !GetUtils.isNum(priceC.text)
        ? 'Harga harus dalam angka'
        : '';

    discountError.value = !GetUtils.isNum(discountC.text);
    discountErrorText.value = !GetUtils.isNum(discountC.text)
        ? 'Diskon harus dalam angka'
        : '';

    return nameError.value || priceError.value || discountError.value;
  }

  bool get isChange {
    return data.selectedMenu.value!.name.toLowerCase() !=
            nameC.text.trim().toLowerCase() ||
        data.selectedMenu.value!.price != double.parse(priceC.text.trim()) ||
        data.selectedMenu.value!.discount != double.parse(discountC.text) ||
        data.selectedMenu.value!.description != descriptionC.text ||
        !isSameRecipeList(
          recipeList,
          ingredientData.getRecipeFromRawRecipe(
            data.selectedMenu.value!.recipe,
          ),
        );
  }

  Future<void> submit() async {
    if (!isError) {
      final rawData = json.encode({
        'name': nameC.text.toLowerCase(),
        'price': double.parse(priceC.text),
        'description': descriptionC.text,
        'discount': discountC.text,
        'recipe': recipeList
            .map((e) => {'ingredientId': e.ingredient.id, 'qty': e.qty})
            .toList(),
        'menuCategoryId': selectedCategory.value,
      });
      if (isEdit) {
        if (!isChange) {
          Get.offNamed(backRoute);
        } else {
          var jsonData = json.encode({
            'name': nameC.text.trim().toLowerCase(),
            'price': double.parse(priceC.text.trim()),
            'discount': discountC.text,
            'description': descriptionC.text,
            'recipe': recipeList
                .map((e) => {'ingredientId': e.ingredient.id, 'qty': e.qty})
                .toList(),
          });
          await data.updateMenu(
            id: data.selectedMenu.value!.id,
            data: jsonData,
            backRoute: backRoute,
          );
        }
      } else {
        data.createMenu(rawData);
      }
    }
  }

  void clearField() {
    nameC.clear();
    priceC.clear();
    descriptionC.clear();
    discountC.text = '0';
  }
}
