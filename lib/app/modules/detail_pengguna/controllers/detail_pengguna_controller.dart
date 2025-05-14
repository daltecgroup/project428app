import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/data/user_provider.dart';
import 'package:project428app/app/modules/pengguna/controllers/pengguna_controller.dart';

class DetailPenggunaController extends GetxController {
  PenggunaController userC = Get.find<PenggunaController>();
  GetStorage box = GetStorage();
  UserProvider userP = UserProvider();

  var userId = '-'.obs;
  var createdAt = '-'.obs;
  var name = '-'.obs;
  var status = false.obs;
  var role = ['-'].obs;
  var imgUrl = ''.obs;

  @override
  void onInit() {
    setUserData();
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

  void setUserData() {
    userId.value = box.read(kCurrentUserDetailId);
    var userData = userC.users.singleWhere(
      (user) => user['userId'] == userId.value,
    );

    if (userData != null) {
      name.value = userData['name'];
      status.value = userData['isActive'];
      imgUrl.value = userData['imgUrl'];
      role.clear();
      for (var i = 0; i < userData['role'].length; i++) {
        role.add(userData['role'][i].toString());
      }
      role.refresh();
    }
  }

  void deactiveUser() async {
    status.value = false;
    await userP.deactivateUser(userId.value).then((res) {
      print(res.body);
      userC.getUsers();
    });
  }

  void activateUser() async {
    status.value = true;
    await userP.activateUser(userId.value).then((res) {
      print(res.body);
      userC.getUsers();
    });
  }
}
