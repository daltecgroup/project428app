import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project428app/app/controllers/image_picker_controller.dart';
import 'package:project428app/app/shared/widgets/alert_dialog.dart';
import '../data/providers/user_provider.dart';
import '../data/models/user.dart';

class UserService extends GetxService {
  GetStorage box = GetStorage();
  UserProvider UserP = UserProvider();
  ImagePickerController ImageC = Get.put(
    ImagePickerController(),
    tag: 'user-service',
  );
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

  Future<void> syncUsersData() async {
    users.clear();
    if (box.read('all_user_data') == null) {
      //get data from database
      print('getting users data from online');
      int n = 0;
      while (n < 6 && users.isEmpty) {
        await UserP.getUsers().then((res) async {
          if (res.statusCode == 200) {
            n = 6;
            box.write('all_user_data', json.encode(res.body));
            for (var user in res.body) {
              users.add(User.fromJson(user));
            }
            users.refresh();
          } else {
            // failed to get data, delay 2 seconds and then try again
            await Future.delayed(Duration(seconds: 2));
            n++;
            print('Users: failed to get all user data from database');
          }
        });
      }
    } else {
      // get data from local storage
      print('getting users data from local storage');
      var data = json.decode(box.read('all_user_data'));
      print(data[data.length - 1]['createdAt']);
      DateTime latest = DateTime.now().subtract(Duration(days: 360));
      for (var user in data) {
        User newUser = User.fromJson(user);
        if (newUser.createdAt.isAfter(latest)) {
          latest = newUser.createdAt;
        }
        users.add(newUser);
      }
      print(
        '${latest.year.toString()}-${latest.month.toString().padLeft(2, '0')}-${latest.day.toString().padLeft(2, '0')}',
      );

      users.refresh();
    }
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
    String? pin,
  ) async {
    var data = json.encode({
      'userId': userId ?? currentUser.value!.userId,
      'name': name ?? currentUser.value!.name,
      'phone': phone ?? '',
      'role': role,
      'pin': pin,
    });

    return await UserP.updateUser(id, data).then((res) {
      if (res.statusCode == 200) {
        if (userId != null) currentUser.value!.setUserId(userId);
        if (name != null) currentUser.value!.setName(name);
        if (phone != null) currentUser.value!.setPhone(phone);
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

  Future<void> updateUserImage() async {
    await ImageC.pickImage(ImageSource.camera).then((_) {
      if (ImageC.selectedImage.value != null) {
        UserP.updateUserImage(
          currentUser.value!.id,
          ImageC.selectedImage.value!,
        ).then((res) {
          if (res.statusCode == 200) {
            User updatedUser = User.fromJson(res.body);
            currentUser.value!.imgUrl = updatedUser.imgUrl;
            currentUser.refresh();
            users.refresh();
          } else {
            CustomAlertDialog('Gagal Ubah Gambar', res.body['message']);
          }
        });
      }
    });
  }
}
