import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/data/models/product_non_category.dart';

import '../../shared/widgets/format_waktu.dart';
import 'outlet.dart';
import 'user.dart';

class Sale {
  final String id;
  final String code;
  final List items;
  final int finalPrice;
  final int basePrice;
  final int saving;
  final int paid;
  final int change;
  final Outlet outlet;
  final User cashier;
  final String paymentMethod;
  final int promoUsed;
  final List printHistory;
  final DateTime createdAt;

  Sale({
    required this.id,
    required this.code,
    required this.items,
    required this.finalPrice,
    required this.basePrice,
    required this.saving,
    required this.paid,
    required this.change,
    required this.outlet,
    required this.cashier,
    required this.paymentMethod,
    required this.promoUsed,
    required this.printHistory,
    required this.createdAt,
  });

  // from json
  Sale.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String,
      code = json['code'] as String,
      items =
          (json['items'] as List)
              .map<Map<String, dynamic>>(
                (e) => {
                  "product": ProductNonCategory.fromJson(e['product']),
                  "name": e['name'],
                  "qty": e['qty'],
                  "price": e['price'],
                  "finalPrice": e['finalPrice'],
                  "totalFinalPrice": e['totalFinalPrice'],
                  "discount": e['discount'],
                  "saving": e['saving'],
                  "totalSaving": e['totalSaving'],
                  "_id": e['_id'],
                },
              )
              .toList(),
      finalPrice = json['finalPrice'] as int,
      basePrice = json['basePrice'] as int,
      saving = json['saving'] as int,
      paid = json['paid'] as int,
      change = json['change'] as int,
      outlet = Outlet.fromJson(json['outlet']),
      cashier = User.fromJson(json['cashier']),
      paymentMethod = json['paymentMethod'] as String,
      promoUsed = json['promoUsed'] as int,
      printHistory = json['printHistory'] as List,
      createdAt = MakeLocalDateTime(json['createdAt']);

  String getTotalInRupiah() {
    return "IDR ${NumberFormat("#,##0", "id_ID").format(finalPrice)}";
  }

  String getCreateTime() {
    return "${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }

  String getCreateTimeDate() {
    return "${createdAt.day} ${DateFormat(DateFormat.MONTH).format(createdAt)} ${createdAt.year} ${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }

  int getQty() {
    return items.fold(0, (sum, item) => sum + (item['qty'] as int));
  }
}
