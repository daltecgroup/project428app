import 'package:abg_pos_app/app/data/models/OrderItem.dart';

import 'Address.dart';

class OrderOutlet {
  final String outletId, name;
  final Address address;

  OrderOutlet({
    required this.outletId,
    required this.name,
    required this.address,
  });

  factory OrderOutlet.fromJson(Map<String, dynamic> json) {
    return OrderOutlet(
      outletId: json['outletId'],
      name: json['name'],
      address: Address.fromJson(json['address']),
    );
  }
  Map<String, dynamic> toJson() {
    return {'outletId': outletId, 'name': name, 'address': address.toJson()};
  }
}

class CreatedBy {
  final String userId, name;

  CreatedBy({required this.userId, required this.name});

  factory CreatedBy.fromJson(Map<String, dynamic> json) {
    return CreatedBy(userId: json['userId'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'name': name};
  }
}

class Order {
  final String id, code, status;
  final double totalPrice;
  final OrderOutlet outlet;
  final CreatedBy createdBy;
  final List<OrderItem> items;
  final DateTime createdAt, updatedAt;

  Order({
    required this.id,
    required this.code,
    required this.status,
    required this.totalPrice,
    required this.outlet,
    required this.createdBy,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      code: json['code'],
      status: json['status'],
      totalPrice: double.parse(json['totalPrice'].toString()),
      outlet: OrderOutlet.fromJson(json['outlet']),
      createdBy: CreatedBy.fromJson(json['createdBy']),
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e))
          .toList(),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'status': status,
      'totalPrice': totalPrice,
      'outlet': outlet.toJson(),
      'createdBy': createdBy.toJson(),
      'items': items.map((e) => e.toJson()).toList(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
