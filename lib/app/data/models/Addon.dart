import 'package:abg_pos_app/app/data/models/Recipe.dart';

class Addon {
  final String id, code, name;
  final double price;
  final String? imgUrl;
  final bool isActive;
  final DateTime createdAt, updatedAt;

  final List<Recipe> recipe;

  Addon({
    required this.id,
    required this.code,
    required this.name,
    required this.price,
    required this.imgUrl,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.recipe,
  });

  factory Addon.fromJson(Map<String, dynamic> json) {
    return Addon(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      price: double.parse(json['price'].toString()),
      imgUrl: json['imgUrl'],
      isActive: json['isActive'],
      recipe: (json['recipe'] as List).map((e) => Recipe.fromJson(e)).toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'price': price,
      'imgUrl': imgUrl,
      'isActive': isActive,
      'recipe': recipe.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': createdAt.toIso8601String(),
    };
  }
}
