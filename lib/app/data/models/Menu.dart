import 'package:get/get_utils/src/extensions/num_extensions.dart';

import './RawRecipe.dart';

class Menu {
  final String id, code, name, menuCategoryId, description;
  final double price, discount;
  final String? imgUrl;
  final bool isActive;
  final DateTime createdAt, updatedAt;

  final List<RawRecipe> recipe;

  Menu({
    required this.id,
    required this.code,
    required this.name,
    required this.menuCategoryId,
    required this.description,
    required this.price,
    required this.discount,
    required this.imgUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.recipe,
  });

  factory Menu.fromJson(Map<String, dynamic> json) {
    return Menu(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      menuCategoryId: json['menuCategoryId'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      discount: double.parse(json['discount'].toString()),
      imgUrl: json['imgUrl'],
      isActive: json['isActive'],
      recipe: (json['recipe'] as List)
          .map((e) => RawRecipe.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'menuCategoryId': menuCategoryId,
      'description': description,
      'price': price,
      'discount': discount,
      'imgUrl': imgUrl,
      'isActive': isActive,
      'recipe': recipe
          .map((e) => {'ingredientId': e.ingredientId, 'qty': e.qty})
          .toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': createdAt.toIso8601String(),
    };
  }

  Menu copyWith({
    String? id,
    String? code,
    String? name,
    String? menuCategoryId,
    String? description,
    double? price,
    double? discount,
    String? imgUrl,
    bool? isActive,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<RawRecipe>? recipe,
  }) {
    return Menu(
      id: id ?? this.id,
      code: code ?? this.code,
      name: name ?? this.name,
      menuCategoryId: menuCategoryId ?? this.menuCategoryId,
      description: description ?? this.description,
      price: price ?? this.price,
      discount: discount ?? this.discount,
      imgUrl: imgUrl ?? this.imgUrl,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      recipe: recipe ?? this.recipe,
    );
  }

  double get priceAfterDiscount {
    if (discount == 0) return price;
    return price - ((discount / 100) * price);
  }

  double get savings {
    if (discount == 0) return 0;
    return (discount / 100) * price;
  }
}
