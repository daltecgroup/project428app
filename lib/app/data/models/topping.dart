import 'dart:convert';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/data/models/ingredients.dart';
import 'package:project428app/app/data/providers/topping_provider.dart';
import 'package:project428app/app/shared/widgets/alert_dialog.dart';
import '../../shared/widgets/format_waktu.dart';

class Topping {
  ToppingProvider ToppingP = ToppingProvider();

  String id, code, name;
  int price;
  String? imgUrl;
  bool isActive;
  List<Ingredients> ingredients;
  DateTime createdAt, updatedAt;

  Topping({
    required this.id,
    required this.code,
    required this.name,
    required this.price,
    required this.imgUrl,
    required this.isActive,
    required this.ingredients,
    required this.createdAt,
    required this.updatedAt,
  });

  Topping.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String,
      code = json['code'] as String,
      name = json['name'] as String,
      price = json['price'] as int,
      imgUrl = json['imgUrl'] as String?,
      isActive = json['isActive'] as bool,
      ingredients =
          (json['ingredients'] as List)
              .map((e) => Ingredients.fromJson(e))
              .toList(),
      updatedAt = MakeLocalDateTime(json['updatedAt']),
      createdAt = MakeLocalDateTime(json['createdAt']);

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'code': code,
      'name': name,
      'price': price,
      'imgUrl': imgUrl,
      'isActive': isActive,
      'ingredients': ingredients.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Future<bool> toggleStatus() async {
    bool newStatus = !isActive;
    try {
      Response res = await ToppingP.updateToppingById(
        id,
        json.encode({'isActive': newStatus}),
      );

      if (res.statusCode == 200) {
        isActive = newStatus;
        return true;
      } else {
        CustomAlertDialog('Peringatan', res.body['message']);
        return false;
      }
    } catch (e) {
      CustomAlertDialog('Peringatan', e.toString());
      return false;
    }
  }

  String getPriceInRupiah() {
    return "IDR ${NumberFormat("#,##0", "id_ID").format(price)}";
  }

  String getUpdateDate() {
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(updatedAt);
  }

  String getUpdateTime() {
    return DateFormat(DateFormat.HOUR24_MINUTE).format(updatedAt);
  }

  String getCreateDate() {
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(createdAt);
  }

  String getCreateTime() {
    return DateFormat(DateFormat.HOUR24_MINUTE).format(createdAt);
  }
}
