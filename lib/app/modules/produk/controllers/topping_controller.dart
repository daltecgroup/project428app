import 'package:get/get.dart';
import 'package:project428app/app/services/topping_service.dart';

import '../../../data/models/topping.dart';

class ToppingController extends GetxController {
  Rx<Topping?> selectedTopping = (null as Topping?).obs;
  ToppingService ToppingS = Get.find<ToppingService>();

  @override
  void onInit() {
    super.onInit();
    ToppingS.getAllToppings();
  }
}
