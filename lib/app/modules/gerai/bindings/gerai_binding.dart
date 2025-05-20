import 'package:get/get.dart';

import 'package:project428app/app/modules/gerai/controllers/add_outlet_controller.dart';
import 'package:project428app/app/modules/gerai/controllers/outlet_detail_controller.dart';

import '../controllers/gerai_controller.dart';

class GeraiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OutletDetailController>(
      () => OutletDetailController(),
    );
    Get.lazyPut<AddOutletController>(
      () => AddOutletController(),
    );
    Get.put<GeraiController>(GeraiController());
  }
}
