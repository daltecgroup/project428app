import 'dart:async';
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project428app/app/controllers/image_picker_controller.dart';
import 'package:project428app/app/core/constants/values.dart';
import 'package:project428app/app/core/helpers/file_helper.dart';
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

  Timer? _syncTimer;

  @override
  void onInit() {
    super.onInit();
    // getUsers();
    syncData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void startAutoSync() {
    _syncTimer = Timer.periodic(Duration(seconds: 2), (timer) {
      syncData();
    });
  }

  Future<void> syncData() async {
    try {
      final file = await getLocalFile(userDataFileName);
      if (await file.exists()) await file.delete();
      if (await file.exists()) {
        print('get data from file');
        List<dynamic> userData =
            json.decode(await file.readAsString()) as List<dynamic>;
        setUsers(userData);
        Response res = await UserP.getLatestUsers(
          json.encode({
            'latest':
                getLatestUpdate()
                    .add(Duration(seconds: 1))
                    .toUtc()
                    .toIso8601String(),
          }),
        );

        if (res.body.length > 0) {
          for (var e in res.body) {
            if (e['isDeleted'] == true) {
              users.removeWhere((user) => user.id == e['_id']);
            } else {
              int index = users.indexWhere((user) => user.id == e['_id']);
              print(index);
              if (index != -1) {
                users[index] = User.fromJson(e);
              } else {
                users.add(User.fromJson(e));
              }
            }
          }
          users.refresh();
          await file.writeAsString(
            json.encode(users.map((user) => user.toJson()).toList()),
          );
        } else {
          print('file sudah terupdate');
        }
      } else {
        print('get all data from server');
        Response res = await UserP.getLatestUsers(json.encode({}));
        if (res.statusCode == 200) {
          await file.writeAsString(json.encode(res.body));
          setUsers(res.body);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void setUsers(List userData) {
    List<User> userList = <User>[];
    if (userData.isNotEmpty) {
      for (var user in userData) {
        userList.add(User.fromJson(user));
      }
    }
    users.value = userList;
  }

  DateTime getLatestUpdate() {
    DateTime latest = DateTime.now().subtract(Duration(days: 360));
    for (var user in users) {
      // print(user.updatedAt.isAfter(latest));
      // print(user.updatedAt.toUtc().toIso8601String());
      if (user.updatedAt.isAfter(latest)) {
        latest = user.updatedAt;
      }
    }
    return latest;
  }

  Future<void> getUsers() async {
    syncData();
    // Response res = await UserP.getUsers();

    // if (res.statusCode == 200) {
    //   users.clear();
    //   print(
    //     'Success: Getting all user data from database. Count: ${res.body.length}',
    //   );

    //   List<dynamic> body = res.body as List<dynamic>;
    //   if (body.isNotEmpty) {
    //     for (var user in body) {
    //       users.add(User.fromJson(user));
    //     }
    //     users.refresh();
    //   }
    // } else {
    //   print('Failed: Getting all user data from database');
    // }
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
