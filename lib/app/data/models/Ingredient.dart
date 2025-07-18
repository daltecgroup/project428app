class Ingredient {
  final String id, code, name, unit;
  final double price;
  final DateTime createdAt, updatedAt;
  bool isActive;

  Ingredient({
    required this.id,
    required this.code,
    required this.name,
    required this.unit,
    required this.price,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Ingredient.fromJson(Map<String, dynamic> json) {
    return Ingredient(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      unit: json['unit'],
      price: double.parse(json['price'].toString()),
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
      'unit': unit,
      'price': price,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  String get priceString {
    String result = price.toString();
    if (price % 1 == 0) {
      result = price.round().toString();
    }
    return result;
  }

  void toggleStatus() => isActive = !isActive;
}
