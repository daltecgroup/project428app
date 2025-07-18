import 'package:get/get.dart';

import '../../../../controllers/addon_data_controller.dart';
import '../../../../controllers/ingredient_data_controller.dart';
import '../../../../data/models/Recipe.dart';
import '../../../../routes/app_pages.dart';

class AddonDetailController extends GetxController {
  AddonDetailController({required this.data, required this.ingredientData});
  AddonDataController data;
  IngredientDataController ingredientData;
  final String backRoute = Get.previousRoute;

  RxList<Recipe> recipeList = <Recipe>[].obs;

  @override
  void onInit() {
    super.onInit();
    setRecipe();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void setRecipe() {
    if (data.selectedAddon.value != null) {
      recipeList.value = data.selectedAddon.value!.recipe;
    }
  }

  bool haveSameElements(List a, List b) {
    return a.toSet().containsAll(b) && b.toSet().containsAll(a);
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
}
