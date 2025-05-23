import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/constants.dart';
import 'package:project428app/app/data/user_provider.dart';
import 'package:project428app/app/modules/pengguna/controllers/pengguna_controller.dart';
import 'package:project428app/app/services/auth_service.dart';

class DetailPenggunaController extends GetxController {
  PenggunaController userC = Get.find<PenggunaController>();
  GetStorage box = GetStorage();
  UserProvider userP = UserProvider();
  AuthService AuthS = Get.find<AuthService>();

  var userId = '-'.obs;
  var createdAt = '-'.obs;
  var name = '-'.obs;
  var status = false.obs;
  var role = ['-'].obs;
  var imgUrl = ''.obs;

  RxBool myOwn = false.obs;

  @override
  void onInit() {
    setUserData();
    super.onInit();
  }

  @override
  void onReady() {
    setUserData();
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
      createdAt.value = userData['createdAt'];
      role.clear();
      for (var i = 0; i < userData['role'].length; i++) {
        role.add(userData['role'][i].toString());
      }
      role.refresh();
      if (userId.value == AuthS.box.read('userProfile')['userId']) {
        myOwn.value = true;
      }
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

  void deleteUser() async {
    await userP.deleteUser(userId.value).then((res) {
      print(res.body);
      userC.getUsers();
      Get.back();
      Get.offNamed('/pengguna');
    });
  }
}
