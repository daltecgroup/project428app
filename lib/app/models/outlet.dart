import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/format_waktu.dart';

class Outlet {
  final String id, name, code, imgUrl;
  final bool isActive;
  final Map address;
  final List owner, operator, spvarea;
  final DateTime foundedAt, createdAt, updatedAt;

  Outlet(
    this.id,
    this.name,
    this.code,
    this.isActive,
    this.imgUrl,
    this.address,
    this.owner,
    this.operator,
    this.spvarea,
    this.foundedAt,
    this.createdAt,
    this.updatedAt,
  );

  Outlet.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String,
      code = json['code'] as String,
      name = json['name'] as String,
      isActive = json['isActive'] as bool,
      imgUrl = json['imgUrl'] as String,
      address = {
        'street': json['address']['street'] as String,
        'village': json['address']['village'] as String,
        'district': json['address']['district'] as String,
        'regency': json['address']['regency'] as String,
        'province': json['address']['province'] as String,
      },
      owner = json['owner'] as List,
      operator = json['operator'] as List,
      spvarea = json['spvarea'] as List,
      foundedAt = MakeLocalDateTime(json['foundedAt']),
      createdAt = MakeLocalDateTime(json['createdAt']),
      updatedAt = MakeLocalDateTime(json['updatedAt']);

  String getCreateTime() {
    return "${createdAt.day} ${DateFormat(DateFormat.MONTH).format(createdAt)} ${createdAt.year} ${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }

  String getFoundedTime() {
    return "${foundedAt.day} ${DateFormat(DateFormat.MONTH).format(foundedAt)} ${foundedAt.year} ${foundedAt.hour}:${foundedAt.minute.isLowerThan(10) ? '0${foundedAt.minute}' : foundedAt.minute} WIB";
  }

  String getUpdatedTime() {
    return "${updatedAt.day} ${DateFormat(DateFormat.MONTH).format(updatedAt)} ${updatedAt.year} ${updatedAt.hour}:${updatedAt.minute.isLowerThan(10) ? '0${updatedAt.minute}' : updatedAt.minute} WIB";
  }

  String getFullAddress() {
    return '${address['street']}, ${address['district']}, ${address['regency']}, ${address['province']}';
  }
}
