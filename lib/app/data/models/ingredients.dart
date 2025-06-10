class Ingredients {
  final String stock, name, unit;
  final int price, qty;

  Ingredients({
    required this.stock,
    required this.name,
    required this.unit,
    required this.price,
    required this.qty,
  });

  Ingredients.fromJson(Map<String, dynamic> json)
    : stock = json['stock'] as String,
      name = json['name'] as String,
      unit = json['unit'] as String,
      price = json['price'] as int,
      qty = json['qty'] as int;

  Map<String, dynamic> toJson() {
    return {
      'stock': stock,
      'name': name,
      'unit': unit,
      'price': price,
      'qty': qty,
    };
  }
}
