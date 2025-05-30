import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:project428app/app/models/product_category.dart';
import 'package:project428app/app/widgets/format_waktu.dart';

import 'stock.dart';

class Ingredient {
  Stock? stock;
  int qty;
  final String id;

  Ingredient({required this.qty, required this.stock, required this.id});

  Ingredient.fromJson(Map<String, dynamic> json)
    : stock =
          json['stock'] == null
              ? null as Stock?
              : Stock.fromJson(json['stock']),
      qty = json['qty'] as int,
      id = json['_id'];
}

class Product {
  final String id;
  final String code;
  final String name;
  final int price;
  final int discount;
  final String description;
  final String imgUrl;
  final ProductCategory? category;
  final List<Ingredient> ingredients;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;

  Product(
    this.id,
    this.code,
    this.name,
    this.price,
    this.discount,
    this.description,
    this.imgUrl,
    this.category,
    this.ingredients,
    this.isActive,
    this.updatedAt,
    this.createdAt,
  );

  Product.fromJson(Map<String, dynamic> json)
    : id = json['_id'] as String,
      code = json['code'] as String,
      name = json['name'] as String,
      price = json['price'] as int,
      discount = json['discount'] as int,
      description = json['description'] as String,
      imgUrl = json['imgUrl'] as String,
      category =
          json['category'] == null
              ? null as ProductCategory?
              : ProductCategory.fromJson(json['category']),
      ingredients =
          (json['ingredients'] as List)
              .map((e) => Ingredient.fromJson(e))
              .toList(),
      isActive = json['isActive'] as bool,
      updatedAt = MakeLocalDateTime(json['updatedAt']),
      createdAt = MakeLocalDateTime(json['createdAt']);

  String getUpdateDate() {
    return DateFormat(DateFormat.YEAR_ABBR_MONTH_DAY).format(createdAt);
  }

  String getUpdateTime() {
    return DateFormat(DateFormat.HOUR24_MINUTE).format(createdAt);
  }

  String getCreateTime() {
    return "${createdAt.day} ${DateFormat(DateFormat.MONTH).format(createdAt)} ${createdAt.year} ${createdAt.hour}:${createdAt.minute.isLowerThan(10) ? '0${createdAt.minute}' : createdAt.minute} WIB";
  }

  String getPriceInRupiah() {
    return "IDR ${NumberFormat("#,##0", "id_ID").format(price)}";
  }

  int getFinalPrice() {
    double finalPrice = 0;
    finalPrice = price - (price * discount / 100);
    return finalPrice.ceil();
  }

  int getSavings() {
    double finalPrice = 0;
    finalPrice = price - (price * discount / 100);
    return price - finalPrice.ceil();
  }

  String getPriceInRupiahAfterDiscount() {
    double finalPrice = 0;

    finalPrice = price - (price * discount / 100);
    return "IDR ${NumberFormat("#,##0", "id_ID").format(finalPrice)}";
  }
}
