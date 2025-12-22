import 'package:abg_pos_app/app/utils/constants/string_value.dart';

class RequestOutlet {
  final String code, name, id;

  RequestOutlet({required this.code, required this.name, required this.id});

  factory RequestOutlet.fromJson(Map<String, dynamic> json) {
    return RequestOutlet(
      code: json['code'],
      name: json['name'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'name': name, 'id': id};
  }
}

class RequestedBy {
  final String id, userId, name;

  RequestedBy({required this.userId, required this.name, required this.id});

  factory RequestedBy.fromJson(Map<String, dynamic> json) {
    
    return RequestedBy(
      id: json['_id'],
      userId: json['userId'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    
    return {'_id': id, 'userId': userId, 'name': name};
  }
}

class UserId {
  final String _id, name;
  UserId({required String id, required this.name}) : _id = id;

  factory UserId.fromJson(Map<String, dynamic> json) {
    return UserId(id: json['_id'], name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'_id': _id, 'name': name};
  }
}

class ResolvedBy {
  final String name;
  final UserId userId;

  ResolvedBy({required this.name, required this.userId});
  factory ResolvedBy.fromJson(Map<String, dynamic> json) {
    return ResolvedBy(
      name: json['name'],
      userId: UserId.fromJson(json['userId']),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'userId': userId.toJson()};
  }
}

class Request {
  final String id, type, targetId;
  String status;
  String? targetCode, reason, adminResponse, deletedBy;
  final DateTime createdAt;
  bool isCompleted, isDeleted;
  DateTime updatedAt;
  DateTime? resolvedAt, deletedAt;
  final RequestOutlet outlet;
  final RequestedBy requestedBy;
  ResolvedBy? resolvedBy;

  Request({
    required this.id,
    required this.type,
    required this.targetId,
    required this.status,
    required this.targetCode,
    required this.reason,
    required this.adminResponse,
    required this.deletedBy,
    required this.createdAt,
    required this.isCompleted,
    required this.isDeleted,
    required this.updatedAt,
    required this.resolvedAt,
    required this.deletedAt,
    required this.outlet,
    required this.requestedBy,
    required this.resolvedBy,
  });

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['id'] ?? '',
      type: json['type'] ?? '',
      targetId: json['targetId'] ?? '',
      targetCode: json['targetCode'],
      status: json['status'] ?? 'pending',
      reason: json['reason'],
      adminResponse: json['adminResponse'],
      deletedBy: json['deletedBy'],
      isCompleted: json['isCompleted'] ?? false,
      isDeleted: json['isDeleted'] ?? false,
      // Helper untuk parsing tanggal agar lebih aman
      createdAt: DateTime.parse(json['createdAt'] ?? ''),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ''),
      resolvedAt: DateTime.tryParse(json['resolvedAt'] ?? ''),
      deletedAt: DateTime.tryParse(json['deletedAt'] ?? ''),
      // Parsing Nested Objects
      outlet: RequestOutlet.fromJson(json['outlet'] ?? {}),
      requestedBy: RequestedBy.fromJson(json['requestedBy'] ?? {}),
      resolvedBy: json['resolvedBy'] != null 
          ? ResolvedBy.fromJson(json['resolvedBy']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'type': type,
      'targetId': targetId,
      'targetCode': targetCode,
      'status': status,
      'reason': reason,
      'adminResponse': adminResponse,
      'deletedBy': deletedBy,
      'createdAt': createdAt.toIso8601String(),
      'isCompleted': isCompleted,
      'isDeleted': isDeleted,
      'updatedAt': updatedAt.toIso8601String(),
      'resolvedAt': resolvedAt?.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'outlet': outlet.toJson(),
      'requestedBy': requestedBy.toJson(),
      'resolvedBy': resolvedBy?.toJson(),
    };
  }

  String get requestType {
    switch (type) {
      case StringValue.DEL_ORDER: return 'Hapus Order';
      case StringValue.DEL_SALE: return 'Hapus Penjualan';
      default: return 'Tak Diketahui';
    }
  }
}
