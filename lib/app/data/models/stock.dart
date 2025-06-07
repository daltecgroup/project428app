import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/data/providers/stock_provider.dart';
import 'package:project428app/app/shared/widgets/format_waktu.dart';

class Stock {
  StockProvider StockP = StockProvider();
  final String id, stockId, name, unit;
  final int price;
  bool isActive;
  final DateTime updatedAt, createdAt;

  Stock(
    this.id,
    this.stockId,
    this.name,
    this.unit,
    this.price,
    this.isActive,
    this.updatedAt,
    this.createdAt,
  );

  Stock.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String,
      stockId = json['stockId'] as String,
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

  Future<bool> changeStatus() async {
    print('Stock: Start to change status');
    Response? response = null as Response?;

    try {
      if (isActive == true) response = await StockP.deactivateStock(id);
      if (isActive == false) response = await StockP.reactivateStock(id);
    } catch (e) {
      print(e);
    }

    if (response!.statusCode == 200) {
      isActive = !isActive;
      return true;
    } else {
      return false;
    }
  }

  String getLastUpdateTime() {
    return "${updatedAt.day} ${DateFormat(DateFormat.MONTH, 'id').format(updatedAt)} ${updatedAt.year} ${updatedAt.hour}:${updatedAt.minute.isLowerThan(10) ? '0${updatedAt.minute}' : updatedAt.minute} WIB";
  }

  String getCreateTime() {
    return "${createdAt.day} ${DateFormat(DateFormat.MONTH, 'id').format(createdAt)} ${createdAt.year} ${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }
}
