import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/models/login.dart';
import 'package:project428app/app/services/operator_service.dart';
import 'package:project428app/app/services/personalization_service.dart';

class LoginAsController extends GetxController {
  GetStorage box = GetStorage();
  Personalization c = Get.find<Personalization>();
  OperatorService operatorS = Get.put(OperatorService());
  late Login userdata;

  @override
  void onInit() {
    c.userdata = Login.fromJson(box.read(kUserData));
    userdata = c.userdata;
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
