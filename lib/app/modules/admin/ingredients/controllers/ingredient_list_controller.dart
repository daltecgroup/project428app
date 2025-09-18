import 'package:abg_pos_app/app/data/models/Ingredient.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../controllers/ingredient_data_controller.dart';

class IngredientListController extends GetxController {
  IngredientListController({required this.data});
  IngredientDataController data;

  final searchC = TextEditingController();
  final keyword = ''.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await data.syncData();
  }

  @override
  void onClose() {
    searchC.dispose();
    super.onClose();
  }

  Future<void> refreshIngredients() => data.syncData(refresh: true);

  void searchKeyword() => keyword(searchC.text.toLowerCase().trim());

  List<Ingredient> filteredIngredients({bool? status, String? keyword}) {
    List<Ingredient> list = data.ingredients;

    if (status != null) {
      list = data.ingredients.where((p0) => p0.isActive == status).toList();
    }

    if (keyword != null) {
      list = data.ingredients
          .where((p0) => p0.name.contains(keyword.toLowerCase().trim()))
          .toList();
    }

    return list;
  }

  String? get getCurrentRole => box.getValue(AppConstants.KEY_CURRENT_ROLE);
}
