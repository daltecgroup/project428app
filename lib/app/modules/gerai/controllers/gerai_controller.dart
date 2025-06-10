import 'package:get/get.dart';
import 'package:project428app/app/data/providers/outlet_provider.dart';
import 'package:project428app/app/services/outlet_service.dart';

class GeraiController extends GetxController {
  OutletProvider OutletP = OutletProvider();
  OutletService OutletS = Get.find<OutletService>();

  @override
  void onInit() {
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
