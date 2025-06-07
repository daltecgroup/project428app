import 'package:get/get.dart';
import 'package:project428app/app/data/models/user.dart';

import '../../shared/widgets/format_waktu.dart';

class Attendance {
  final User user;
  final String id, type, imgUrl;
  final DateTime createdAt;

  Attendance(this.user, this.id, this.type, this.imgUrl, this.createdAt);

  Attendance.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String,
      type = json['type'] as String,
      imgUrl = json['imgUrl'] as String,
      user = User.fromJson(json['user']),
      createdAt = MakeLocalDateTime(json['createdAt']);

  String getCreateTime() {
    return "${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }
}
