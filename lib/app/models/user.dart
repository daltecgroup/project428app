import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/format_waktu.dart';

class User {
  final String id;
  final String userId;
  final String name;
  final List role;
  final String imgUrl;
  final bool isActive;
  final String phone;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime lastSeen;

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

  String getUpdatedTime() {
    return "${updatedAt.day} ${DateFormat(DateFormat.MONTH).format(updatedAt)} ${updatedAt.year} ${updatedAt.hour}:${updatedAt.minute.isLowerThan(10) ? '0${updatedAt.minute}' : updatedAt.minute} WIB";
  }

  String getCreateTime() {
    return "${createdAt.day} ${DateFormat(DateFormat.MONTH).format(createdAt)} ${createdAt.year} ${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }

  String getLastSeen() {
    return "${lastSeen.day} ${DateFormat(DateFormat.MONTH).format(lastSeen)} ${lastSeen.year} ${lastSeen.hour}:${lastSeen.minute.isLowerThan(10) ? '0${lastSeen.minute}' : lastSeen.minute} WIB";
  }
}
