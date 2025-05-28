import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../widgets/format_waktu.dart';
import 'outlet.dart';

class Order {
  final String id, code, status;
  final Outlet outlet;
  final List<OrderItem> items;
  final int total;
  final bool isActive;
  final DateTime createdAt;

  Order(
    this.id,
    this.code,
    this.outlet,
    this.status,
    this.items,
    this.total,
    this.isActive,
    this.createdAt,
  );

  Order.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String,
      code = json['code'] as String,
      outlet = Outlet.fromJson(json['outlet']),
      items =
          (json['items'] as List).map((e) => OrderItem.fromJson(e)).toList(),
      total = json['total'] as int,
      status = json['status'] as String,
      isActive = json['isActive'] as bool,
      createdAt = MakeLocalDateTime(json['createdAt']);

  String getCreateTimeDate() {
    return "${createdAt.day} ${DateFormat(DateFormat.MONTH).format(createdAt)} ${createdAt.year} ${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }

  String getTotalInIDR() {
    return "IDR ${NumberFormat("#,##0", "id_ID").format(total)}";
  }
}

class OrderItem {
  final String name, stock;
  final int qty, price;
  final bool accepted;

  OrderItem(this.name, this.stock, this.qty, this.price, this.accepted);

  OrderItem.fromJson(Map<String, dynamic> json)
    : stock = json['stock'] as String,
      name = json['name'] as String,
      qty = json['qty'] as int,
      price = json['price'] as int,
      accepted = json['accepted'] as bool;
}
