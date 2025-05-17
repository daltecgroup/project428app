import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/models/user.dart';
import 'package:project428app/app/services/personalization_service.dart';

class LoginAsController extends GetxController {
  GetStorage box = GetStorage();
  Personalization c = Get.find<Personalization>();
  late User userdata;

  @override
  void onInit() {
    c.userdata = User.fromJson(box.read(kUserData));
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
