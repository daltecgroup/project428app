class OrderItem {
  final String ingredientId, name, unit;
  final String? notes, outletInventoryTransactionId;
  bool isAccepted;
  final double qty, price;

  OrderItem({
    required this.ingredientId,
    required this.name,
    required this.unit,
    required this.notes,
    required this.outletInventoryTransactionId,
    required this.isAccepted,
    required this.qty,
    required this.price,
  });

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
      ingredientId: json['ingredientId'],
      name: json['name'],
      unit: json['ingredientId'],
      notes: json['notes'],
      outletInventoryTransactionId: json['outletInventoryTransactionId'],
      isAccepted: json['isAccepted'],
      qty: double.parse(json['qty'].toString()),
      price: double.parse(json['price'].toString()),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredientId': ingredientId,
      'name': name,
      'unit': unit,
      'notes': notes,
      'outletInventoryTransactionId': outletInventoryTransactionId,
      'isAccepted': isAccepted,
      'qty': qty,
      'price': price,
    };
  }

  void changeStatus(bool value) => isAccepted = value;
}
