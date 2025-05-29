import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/data/order_provider.dart';
import 'package:project428app/app/models/stock.dart';

import '../widgets/format_waktu.dart';
import 'outlet.dart';

class Order {
  OrderProvider OrderP = OrderProvider();

  final String id, code;
  final Outlet outlet;
  List<OrderItem> items;
  final int total;
  final DateTime createdAt;
  String status;

  Order(
    this.id,
    this.code,
    this.outlet,
    this.status,
    this.items,
    this.total,
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
      createdAt = MakeLocalDateTime(json['createdAt']);

  Future<bool> setStatus(String newStatus) async {
    return OrderP.updateOrderById(
      code,
      json.encode({'status': newStatus}),
    ).then((res) {
      if (res.statusCode != null && res.statusCode == 200) {
        status = newStatus;
        return true;
      } else {
        Get.snackbar('Gagal Mengubah Status', res.body['error']);
        return false;
      }
    });
  }

  void statusCheck() {
    int acceptCount = 0;
    for (var item in items) {
      if (item.accepted) {
        acceptCount++;
      }
    }

    if (acceptCount == items.length) {
      status = 'accepted';
    } else {
      status = 'returned';
    }
  }

  Future<bool> changeItemStatus(int index, bool status) async {
    var initialItems = items;
    var initialStatus = this.status;

    items[index].changeStatus(status);
    statusCheck();

    await OrderP.updateOrderById(
          code,
          json.encode({
            'status': this.status,
            'items':
                items
                    .map(
                      (item) => {
                        'stock': item.stock.id,
                        'name': item.name,
                        'qty': item.qty,
                        'price': item.price,
                        'accepted': item.accepted,
                      },
                    )
                    .toList(),
          }),
        )
        .then((res) {
          if (res.statusCode == 200) {
            return true;
          } else {
            this.status = initialStatus;
            items = initialItems;
            return false;
          }
        })
        .onError((_, __) {
          return false;
        });
    return false;
  }

  String getCreateTimeDate() {
    return "${createdAt.day} ${DateFormat(DateFormat.MONTH).format(createdAt)} ${createdAt.year} ${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }

  String getTotalInIDR() {
    return "IDR ${NumberFormat("#,##0", "id_ID").format(total)}";
  }
}

class OrderItem {
  final String name;
  final Stock stock;
  final int qty, price;
  bool accepted;

  OrderItem(this.name, this.stock, this.qty, this.price, this.accepted);

  OrderItem.fromJson(Map<String, dynamic> json)
    : stock = Stock.fromJson(json['stock']),
      name = json['name'] as String,
      qty = json['qty'] as int,
      price = json['price'] as int,
      accepted = json['accepted'] as bool;

  String getPriceInIDR() {
    return "IDR ${NumberFormat("#,##0", "id_ID").format(price)}";
  }

  String getTotalInIDR() {
    return "IDR ${NumberFormat("#,##0", "id_ID").format(qty * price)}";
  }

  void changeStatus(bool status) {
    accepted = status;
  }
}
