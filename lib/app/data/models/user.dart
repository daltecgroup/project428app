import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/data/providers/user_provider.dart';
import 'package:project428app/app/shared/widgets/alert_dialog.dart';

import '../../shared/widgets/format_waktu.dart';

class User {
  UserProvider UserP = UserProvider();
  String id, userId, name;
  String? imgUrl, phone;
  List role;
  bool isActive;
  DateTime updatedAt, lastSeen;
  final DateTime createdAt;

  User(
    this.id,
    this.userId,
    this.name,
    this.role,
    this.imgUrl,
    this.isActive,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.lastSeen,
  );

  User.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String,
      userId = json['userId'] as String,
      name = json['name'] as String,
      role = json['role'],
      imgUrl = json['imgUrl'],
      isActive = json['isActive'],
      phone = json['phone'],
      createdAt = MakeLocalDateTime(json['createdAt']),
      updatedAt = MakeLocalDateTime(json['updatedAt']),
      lastSeen = MakeLocalDateTime(json['lastSeen']);

  void setRoles(List newRole) {
    role = newRole;
  }

  void setUserId(String newUserId) {
    userId = newUserId;
  }

  void setName(String newName) {
    name = newName;
  }

  void setPhone(String newPhone) {
    phone = newPhone;
  }

  String getUpdatedTime() {
    return "${updatedAt.day} ${DateFormat(DateFormat.MONTH).format(updatedAt)} ${updatedAt.year} ${updatedAt.hour}:${updatedAt.minute.isLowerThan(10) ? '0${updatedAt.minute}' : updatedAt.minute} WIB";
  }

  String getCreateTime() {
    return "${createdAt.day} ${DateFormat(DateFormat.MONTH).format(createdAt)} ${createdAt.year} ${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }

  String getLastSeen() {
    return "${lastSeen.day} ${DateFormat(DateFormat.MONTH).format(lastSeen)} ${lastSeen.year} ${lastSeen.hour}:${lastSeen.minute.isLowerThan(10) ? '0${lastSeen.minute}' : lastSeen.minute} WIB";
  }

  Future<bool> changeStatus() async {
    bool status = !isActive;
    print('User: Start to change status');
    return await UserP.updateUser(id, json.encode({'isActive': status})).then((
      res,
    ) {
      if (res.statusCode == 200) {
        print('User: Changing status in database success');
        isActive = status;
        return true;
      } else {
        CustomAlertDialog(
          'Gagal Mengubah Status',
          res.body['message'].toString(),
        );
        return false;
      }
    });
  }
}
