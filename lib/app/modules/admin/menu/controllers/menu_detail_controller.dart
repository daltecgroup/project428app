import 'package:abg_pos_app/app/controllers/menu_category_data_controller.dart';
import 'package:abg_pos_app/app/controllers/menu_data_controller.dart';
import 'package:get/get.dart';

import '../../../../controllers/ingredient_data_controller.dart';
import '../../../../data/models/Recipe.dart';
import '../../../../routes/app_pages.dart';

class MenuDetailController extends GetxController {
  MenuDetailController({
    required this.data,
    required this.ingredientData,
    required this.categoryData,
  });

  MenuDataController data;
  IngredientDataController ingredientData;
  MenuCategoryDataController categoryData;

  final String backRoute = Get.previousRoute;

  RxList<Recipe> recipeList = <Recipe>[].obs;

  @override
  void onInit() {
    super.onInit();
    setRecipe();
    data.selectedMenu.listen((p0) => setRecipe());
  }

  @override
  void onClose() {
    data.selectedMenu.call();
    super.onClose();
  }

  void setRecipe() {
    if (data.selectedMenu.value != null) {
      recipeList.value = ingredientData.getRecipeFromRawRecipe(
        data.selectedMenu.value!.recipe,
      );
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
}
