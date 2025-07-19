class LastSyncedBy {
  final String userId, userName;

  LastSyncedBy({required this.userId, required this.userName});

  factory LastSyncedBy.fromJson(Map<String, dynamic> json) {
    return LastSyncedBy(
      userId: json['userId'] as String,
      userName: json['userName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'userName': userName};
  }
}

class OutletInventoryIngredient {
  final String ingredientId, name, unit;
  final double currentQty, price;
  final DateTime lastQuantityUpdated;

  OutletInventoryIngredient({
    required this.ingredientId,
    required this.name,
    required this.unit,
    required this.currentQty,
    required this.price,
    required this.lastQuantityUpdated,
  });

  factory OutletInventoryIngredient.fromJson(Map<String, dynamic> json) {
    return OutletInventoryIngredient(
      ingredientId: json['ingredientId'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
      currentQty: double.parse(json['currentQty']),
      price: double.parse(json['price']),
      lastQuantityUpdated: DateTime.parse(
        json['lastQuantityUpdated'] as String,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ingredientId': ingredientId,
      'name': name,
      'unit': unit,
      'currentQty': currentQty,
      'price': price,
      'lastQuantityUpdated': lastQuantityUpdated.toIso8601String(),
    };
  }
}

class OutletInventory {
  final String id;
  final DateTime createdAt, updatedAt, lastSyncedAt;
  final LastSyncedBy lastSyncedBy;
  final List<OutletInventoryIngredient> ingredients;

  OutletInventory({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.lastSyncedAt,
    required this.lastSyncedBy,
    required this.ingredients,
  });

  factory OutletInventory.fromJson(Map<String, dynamic> json) {
    return OutletInventory(
      id: json['id'] as String,
      lastSyncedBy: LastSyncedBy.fromJson(json['lastSyncedBy']),
      ingredients: (json['ingredients'] as List)
          .map((e) => OutletInventoryIngredient.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      lastSyncedAt: DateTime.parse(json['lastSyncedAt'] as String),
    );
  }
}
