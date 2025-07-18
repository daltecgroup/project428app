class RawRecipe {
  final String ingredientId;
  final double qty;

  RawRecipe({required this.ingredientId, required this.qty});

  factory RawRecipe.fromJson(Map<String, dynamic> json) {
    return RawRecipe(
      ingredientId: json['ingredientId'],
      qty: double.parse(json['qty'].toString()),
    );
  }
}
