import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/widgets/format_waktu.dart';

class Stock {
  final String stockId;
  final String name;
  final String unit;
  final int price;
  final bool isActive;
  final DateTime updatedAt;
  final DateTime createdAt;

  Stock(
    this.stockId,
    this.name,
    this.unit,
    this.price,
    this.isActive,
    this.updatedAt,
    this.createdAt,
  );

  Stock.fromJson(Map<String, dynamic> json)
    : stockId = json['stockId'] as String,
      name = json['name'] as String,
      unit = json['unit'] as String,
      price = json['price'] as int,
      isActive = json['isActive'] as bool,
      updatedAt = MakeLocalDateTime(json['updatedAt']),
      createdAt = MakeLocalDateTime(json['createdAt']);

  String getPriceWithUnit() {
    return "IDR ${NumberFormat("#,##0", "id_ID").format(price)}/${unit == 'volume'
        ? 'Liter'
        : unit == 'weight'
        ? 'Kg'
        : 'Pcs'}";
  }

  String getLastUpdateTime() {
    return "${updatedAt.day}/${updatedAt.month}/${updatedAt.year} ${updatedAt.hour}:${updatedAt.minute.isLowerThan(10) ? '0${updatedAt.minute}' : updatedAt.minute}";
  }
}

class StockHistory {
  final String id;
  final String stock;
  final String content;
  final DateTime createdAt;

  StockHistory(this.id, this.stock, this.content, this.createdAt);

  StockHistory.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String,
      stock = json['stock'] as String,
      content = json['content'] as String,
      createdAt = MakeLocalDateTime(json['createdAt']);

  String getUpdateTimeText() {
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(createdAt);
  }

  String getCreateTime() {
    return "${createdAt.day} ${DateFormat(DateFormat.MONTH).format(createdAt)} ${createdAt.year} ${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }
}
