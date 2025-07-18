import 'package:abg_pos_app/app/data/models/Ingredient.dart';

class Recipe {
  final Ingredient ingredient;
  double qty;

  Recipe({required this.ingredient, required this.qty});

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      ingredient: Ingredient.fromJson(json['ingredientId']),
      qty: double.parse(json['qty'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {'ingredientId': ingredient.toJson(), 'qty': qty};
  }

  void addQty(double number) {
    qty += number;
  }

  void subtractQty(double number) {
    if (qty > 0.0) {
      qty -= number;
    } else {
      qty = 0.0;
    }
  }

  void setQty(double number) {
    qty = number;
  }

  bool get isNotEmpty => qty > 0;
}
