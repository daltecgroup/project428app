import 'package:get/get.dart';
import '../data/providers/user_provider.dart';
import '../data/models/user.dart';

class UserDataController extends GetxController {
  UserProvider UserP = UserProvider();
  RxList<User> users = <User>[].obs;

  @override
  Future<void> onInit() async {
    // todo: implement onInit
    super.onInit();
    await getUsers();
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
    users.clear();
    await UserP.getUsers().then((res) {
      if (res.statusCode == 200) {
        for (var e in res.body) {
          users.add(User.fromJson(e));
        }
      }
    });
  }

  List<User> getUserByRole(String role, List exceptionIds) {
    List<User> list = <User>[];
    for (var e in users) {
      var add = false;
      if (e.role.contains(role) && e.isActive) {
        add = true;
        if (exceptionIds.isEmpty) {
          add = true;
        } else {
          for (var ex in exceptionIds) {
            if (ex == e.id) {
              add = false;
            }
          }
        }
      }
      if (add) {
        list.add(e);
      }
    }
    return list;
  }

  Future<void> updateUser(String id, dynamic data) async {
    await UserP.updateUser(id, data);
  }
}
