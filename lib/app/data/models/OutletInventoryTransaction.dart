import 'package:abg_pos_app/app/data/models/Address.dart';

class OITIngredient {
  final String ingredientId, name, unit;

  OITIngredient({
    required this.ingredientId,
    required this.name,
    required this.unit,
  });

  factory OITIngredient.fromJson(Map<String, dynamic> json) {
    return OITIngredient(
      ingredientId: json['ingredientId'] as String,
      name: json['name'] as String,
      unit: json['unit'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'ingredientId': ingredientId, 'name': name, 'unit': unit};
  }
}

class OITOutlet {
  final String outletId, name;
  final Address address;

  OITOutlet({
    required this.outletId,
    required this.name,
    required this.address,
  });

  factory OITOutlet.fromJson(Map<String, dynamic> json) {
    return OITOutlet(
      outletId: json['outletId'] as String,
      name: json['name'] as String,
      address: Address.fromJson(json['address']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'outletId': outletId, 'name': name, 'address': address.toJson()};
  }
}

class OITSource {
  final String sourceType, ref;

  OITSource({required this.sourceType, required this.ref});

  factory OITSource.fromJson(Map<String, dynamic> json) {
    return OITSource(
      sourceType: json['sourceType'] as String,
      ref: json['ref'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'sourceType': sourceType, 'ref': ref};
  }
}

class OITCreatedBy {
  final String userId, name;

  OITCreatedBy({required this.userId, required this.name});

  factory OITCreatedBy.fromJson(Map<String, dynamic> json) {
    return OITCreatedBy(
      userId: json['userId'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'name': name};
  }
}

class OutletinventoryTransaction {
  final String id, code, transactionType;
  final double price, qty;
  final DateTime createdAt;
  final OITIngredient ingredient;
  final OITOutlet outlet;
  final OITSource source;
  final OITCreatedBy createdBy;
  String? evidence, notes;

  OutletinventoryTransaction({
    required this.id,
    required this.code,
    required this.transactionType,
    required this.price,
    required this.qty,
    required this.createdAt,
    required this.ingredient,
    required this.outlet,
    required this.source,
    required this.createdBy,
    this.evidence,
    this.notes,
  });

  factory OutletinventoryTransaction.fromJson(Map<String, dynamic> json) {
    return OutletinventoryTransaction(
      id: json['id'] as String,
      code: json['code'] as String,
      transactionType: json['transactionType'] as String,
      price: double.parse(json['price'].toString()),
      qty: double.parse(json['qty'].toString()),
      createdAt: DateTime.parse(json['createdAt'] as String),
      ingredient: OITIngredient.fromJson(json['ingredient']),
      outlet: OITOutlet.fromJson(json['outlet']),
      source: OITSource.fromJson(json['source']),
      createdBy: OITCreatedBy.fromJson(json['createdBy']),
      evidence: json['evidence'],
      notes: json['notes'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'transactionType': transactionType,
      'price': price,
      'qty': qty,
      'createdAt': createdAt.toIso8601String(),
      'ingredient': ingredient.toJson(),
      'outlet': outlet.toJson(),
      'source': source.toJson(),
      'createdBy': createdBy.toJson(),
      'evidence': evidence,
      'notes': notes,
    };
  }
}
