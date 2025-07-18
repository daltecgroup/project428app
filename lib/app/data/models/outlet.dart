import 'package:abg_pos_app/app/data/models/Address.dart';

class Outlet {
  final String id, code, name;
  final List franchisees, spvAreas, operators;
  final bool isActive;
  final String? imgUrl;
  final DateTime createdAt, updatedAt;
  final DateTime? foundedAt;
  final Address address;

  Outlet({
    required this.id,
    required this.code,
    required this.name,
    required this.franchisees,
    required this.spvAreas,
    required this.operators,
    required this.isActive,
    required this.imgUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.foundedAt,
    required this.address,
  });

  factory Outlet.fromJson(Map<String, dynamic> json) {
    return Outlet(
      id: json['id'],
      code: json['code'],
      name: json['name'],
      franchisees: json['franchisees'] ?? [],
      spvAreas: json['spvAreas'] ?? [],
      operators: json['operators'] ?? [],
      isActive: json['isActive'],
      imgUrl: json['imgUrl'],
      address: Address.fromJson(json['address']),
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      foundedAt: json['foundedAt'] != null
          ? DateTime.parse(json['foundedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
      'frafranchisees': franchisees,
      'spvspvAreas': spvAreas,
      'operators': operators,
      'isActive': isActive,
      'imgUrl': imgUrl,
      'address': address.toJson(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': createdAt.toIso8601String(),
      'foundedAt': createdAt.toIso8601String(),
    };
  }
}
