import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:project428app/app/widgets/alert_dialog.dart';
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
      print(
        'Success: Getting all user data from database. Count: ${res.body.length}',
      );
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

  Future<bool> updateUser(
    String id,
    String? userId,
    String? name,
    String? phone,
    List role,
  ) async {
    var data = json.encode({
      'userId': userId ?? currentUser.value!.userId,
      'name': name ?? currentUser.value!.name,
      'phone': phone ?? '',
      'role': role,
    });

    return await UserP.updateUser(id, data).then((res) {
      if (res.statusCode == 200) {
        if (userId != null) {
          currentUser.value!.setUserId(userId);
        }

        if (name != null) {
          currentUser.value!.setName(name);
        }
        currentUser.value!.setRoles(role);
        currentUser.refresh();
        users.refresh();
        return true;
      } else {
        CustomAlertDialog('Peringatan', res.body['message']);
        return false;
      }
    });
  }
}
