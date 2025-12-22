import 'package:abg_pos_app/app/utils/helpers/logger_helper.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../../shared/custom_input_with_error.dart';
import '../../../../controllers/ingredient_data_controller.dart';
import '../../../../data/models/Recipe.dart';
import '../../../../utils/constants/app_constants.dart';
import '../../../../utils/constants/string_value.dart';
import '../../../../utils/theme/text_style.dart';

class SelectIngredientController extends GetxController {
  SelectIngredientController({required this.data});
  IngredientDataController data;

  RxList<Recipe> recipe = <Recipe>[].obs;
  RxList<Recipe> selectedRecipeList = <Recipe>[].obs;

  TextEditingController qtyC = TextEditingController();

  @override
  Future<void> onInit() async {
    await data.syncData(refresh: true);
    setRecipe(init: true);
    super.onInit();
  }

  @override
  void onClose() {
    qtyC.dispose();
    super.onClose();
  }

  void clearSelectedRecipeList() {
    selectedRecipeList.clear();
  }

  Future<double?> openQtySelector({double? currentQty}) {
    return Get.defaultDialog(
      title: 'Input Jumlah (gram)',
      titleStyle: AppTextStyle.dialogTitle,
      radius: AppConstants.DEFAULT_BORDER_RADIUS,
      contentPadding: EdgeInsets.all(AppConstants.DEFAULT_PADDING),
      barrierDismissible: false,
      content: CustomInputWithError(
        controller: qtyC,
        inputType: TextInputType.number,
        autoFocus: true,
        onSubmitted: (value) {
          submitQty(currentQty: currentQty);
        },
      ),
      cancel: TextButton(
        onPressed: () {
          Get.back(result: currentQty ?? 0.0,);
          qtyC.clear();
        },
        child: Text(StringValue.CANCEL),
      ),
      confirm: TextButton(
        onPressed: () {
          submitQty(currentQty: currentQty);
        },
        child: Text(StringValue.SAVE),
      ),
    );
  }

  void submitQty({double? currentQty}) {
    if (qtyC.text.isNotEmpty && qtyC.text != '' && GetUtils.isNum(qtyC.text)) {
      Get.back(result: double.parse(qtyC.text));
      qtyC.clear();
    } else {
      Get.back(result: currentQty ?? 0.0,);
      qtyC.clear();
    }
  }

  void setRecipe({required bool init}) {
    if (init &&
        Get.arguments is List<Recipe> &&
        (Get.arguments as List).isNotEmpty) {
      selectedRecipeList.value = Get.arguments as List<Recipe>;
      LoggerHelper.logInfo('Ingredient Input: Init and Argument is not emptly');
    }
    if (data.ingredients.isEmpty) {
      LoggerHelper.logInfo('Ingredient Input: Ingredient Data is empty');
      return;
    }

    final newList = data.ingredients
        .where((ingredient) => ingredient.isActive)
        .map((ingredient) {
          final match = selectedRecipeList.firstWhereOrNull(
            (e) => e.ingredient.id == ingredient.id,
          );
          return Recipe(ingredient: ingredient, qty: match?.qty ?? 0);
        })
        .toList();

    recipe.assignAll(newList);

    // make not empty recipe first and then sort the empty asc alphabetically
    recipe.sort((a, b) {
      if (a.qty > 0 && b.qty <= 0) return -1;
      if (a.qty <= 0 && b.qty > 0) return 1;
      return a.ingredient.name.compareTo(b.ingredient.name);
    });
  }

  void setRecipeList() {
    selectedRecipeList.value = recipe.where((p0) => p0.isNotEmpty).toList();
    setRecipe(init: false);
  }

  List<Recipe> get selectedRecipe {
    return selectedRecipeList;
  }
}
