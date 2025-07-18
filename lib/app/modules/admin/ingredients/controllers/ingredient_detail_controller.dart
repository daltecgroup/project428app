import 'package:get/get.dart';
import '../../../../controllers/ingredient_data_controller.dart';

class IngredientDetailController extends GetxController {
  IngredientDetailController({required this.data});
  IngredientDataController data;
  final String backRoute = Get.previousRoute;
  @override
  Future<void> onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
