import 'package:get/get.dart';
import '../data/user_provider.dart';
import '../models/user.dart';

class UserService extends GetxService {
  UserProvider UserP = UserProvider();
  RxList<User> users = <User>[].obs;
  Rx<User?> currentUser = (null as User?).obs;

  @override
  void onInit() {
    super.onInit();
    getUsers();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getUsers() async {
    Response res = await UserP.getUsers();

    if (res.statusCode == 200) {
      users.clear();
      print('Success: Getting all user data from database. Count: ${res.body.length}');
      List<dynamic> body = res.body as List<dynamic>;
      if (body.isNotEmpty) {
        for (var user in body) {
          users.add(User.fromJson(user));
        }
        users.refresh();
      }
    } else {
      print('Failed: Getting all user data from database');
    }
  }

  Future<bool> deleteUser(String userId, String name) async {
    return await UserP.deleteUser(userId).then((res) {
      if (res.statusCode == 200) {
        return true;
      } else {
        Get.snackbar('Gagal Menghapus $name', '${res.body['message']}');
        return false;
      }
    });
  }
}
