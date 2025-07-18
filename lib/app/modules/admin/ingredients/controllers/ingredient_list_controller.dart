import 'package:abg_pos_app/app/data/models/Ingredient.dart';
import 'package:abg_pos_app/app/utils/constants/app_constants.dart';
import 'package:abg_pos_app/app/utils/helpers/get_storage_helper.dart';
import 'package:get/get.dart';

import '../../../../controllers/ingredient_data_controller.dart';

class IngredientListController extends GetxController {
  IngredientListController({required this.data});
  IngredientDataController data;
  late BoxHelper box;
  @override
  Future<void> onInit() async {
    super.onInit();
    box = BoxHelper();
    await data.syncData();
  }

  Future<void> refreshIngredients() => data.syncData(refresh: true);

  List<Ingredient> filteredIngredients({bool? status}) {
    List<Ingredient> list = data.ingredients;

    if (status != null) {
      list = data.ingredients.where((p0) => p0.isActive == status).toList();
    }

    return list;
  }

  String? get getCurrentRole => box.getValue(AppConstants.KEY_CURRENT_ROLE);
}
