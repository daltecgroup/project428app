import 'BundleCategory.dart';

class Bundle {
  final String id, code, name;
  final String? description;
  final double price;
  bool isActive;
  DateTime createdAt, updatedAt;
  List<BundleCategory> categories;

  Bundle({
    required this.id,
    required this.code,
    required this.name,
    required this.description,
    required this.price,
    required this.categories,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Bundle.fromJson(Map<String, dynamic> json) {
    return Bundle(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      description: json['description'],
      price: double.parse(json['price'].toString()),
      categories: (json['categories'] as List)
          .map((e) => BundleCategory.fromJson(e))
          .toList(),
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'description': description,
      'price': price.round(),
      'categories': categories.map((e) => e.toJson()).toList(),
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': createdAt.toIso8601String(),
    };
  }
}
