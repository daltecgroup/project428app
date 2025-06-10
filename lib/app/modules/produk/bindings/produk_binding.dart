import 'package:get/get.dart';

import 'package:project428app/app/modules/produk/controllers/add_topping_controller.dart';
import 'package:project428app/app/modules/produk/controllers/topping_controller.dart';
import 'package:project428app/app/modules/produk/controllers/topping_detail_controller.dart';

import '../controllers/produk_controller.dart';

class ProdukBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddToppingController>(
      () => AddToppingController(),
    );
    Get.lazyPut<ToppingDetailController>(
      () => ToppingDetailController(),
    );
    Get.lazyPut<ToppingController>(
      () => ToppingController(),
    );
    Get.lazyPut<ProdukController>(
      () => ProdukController(),
    );
  }
}
