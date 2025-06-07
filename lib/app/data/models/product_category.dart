import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/shared/widgets/format_waktu.dart';

class ProductCategory {
  final String id;
  final DateTime createdAt;

  String name;
  bool isActive;

  ProductCategory(this.id, this.name, this.isActive, this.createdAt);

  ProductCategory.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String,
      name = json['name'] as String,
      isActive = json['isActive'] as bool,
      createdAt = MakeLocalDateTime(json['createdAt']);

  String getUpdateTimeText() {
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(createdAt);
  }

  String getCreateTime() {
    return "${createdAt.day} ${DateFormat(DateFormat.MONTH).format(createdAt)} ${createdAt.year} ${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }
}
