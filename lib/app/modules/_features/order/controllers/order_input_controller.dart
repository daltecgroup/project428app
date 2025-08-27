import 'dart:convert';

import 'package:abg_pos_app/app/controllers/order_data_controller.dart';
import 'package:abg_pos_app/app/controllers/outlet_data_controller.dart';
import 'package:abg_pos_app/app/shared/custom_alert.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:get/get.dart';

import '../../../../data/models/Outlet.dart';
import '../../../../data/models/Recipe.dart';
import '../../../../routes/app_pages.dart';

class OrderInputController extends GetxController {
  OrderInputController({required this.data, required this.outletData});
  OrderDataController data;
  OutletDataController outletData;
  final String backRoute = Get.previousRoute;

  Rx<Outlet?> selectedOutlet = (null as Outlet?).obs;

  RxList<Recipe> selectedRecipes = <Recipe>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initOutletData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    selectedOutlet.value = null;
    super.onClose();
  }

  void _initOutletData() {
    if (!box.isNull(AppConstants.KEY_CURRENT_OUTLET)) {
      selectedOutlet.value = outletData.getOutletById(
        box.getValue(AppConstants.KEY_CURRENT_OUTLET),
      );
    }
  }

  Future<List<Recipe>> selectIngredients() async {
    List<Recipe> result = await Get.toNamed(
      Routes.SELECT_INGREDIENT,
      arguments: selectedRecipes,
    );
    return result;
  }

  Future<void> addIngredients() async {
    selectedRecipes.value = await selectIngredients();
  }

  double totalOrderPrice() {
    if (selectedRecipes.isEmpty) return 0.0;
    double total = 0.0;
    for (var recipe in selectedRecipes) {
      total = total + (recipe.qty * recipe.ingredient.price);
    }

    return total;
  }

  bool get isError {
    bool error = false;
    List<String> errors = [];

    if (selectedOutlet.value == null) {
      errors.add('Gerai tujuan belum dipilih');
      error = true;
    }

    if (selectedRecipes.isEmpty) {
      errors.add('Pesanan belum dipilih');
      error = true;
    }

    if (error) {
      customAlertDialog(errors.join('\n'));
    }

    return error;
  }

  Future<void> submit() async {
    if (!isError) {
      final rawData = {};
      rawData['outletId'] = selectedOutlet.value!.id;
      rawData['items'] = selectedRecipes
          .map(
            (recipe) => {
              'ingredientId': recipe.ingredient.id,
              'qty': recipe.qty,
            },
          )
          .toList();

      await data.createOrder(json.encode(rawData), backRoute: backRoute);
    }
  }
}
