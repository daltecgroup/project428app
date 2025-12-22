class AdminNotificationOutlet {
  final String id, code, name;

  AdminNotificationOutlet({
    required this.id,
    required this.code,
    required this.name,
  });

  factory AdminNotificationOutlet.fromJson(Map<String, dynamic> json) {
    return AdminNotificationOutlet(
      id: json['id'] as String,
      code: json['code'] as String,
      name: json['name'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'name': name,
    };
  }
}

class AdminNotification {
  final String id, type, title, content;
  String?  targetId;
  final AdminNotificationOutlet outlet;
  bool isOpened;
  final DateTime createdAt, updatedAt;


  AdminNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.content,
    this.targetId,
    required this.outlet,
    required this.isOpened,
    required this.createdAt,
    required this.updatedAt,
  });

  factory AdminNotification.fromJson(Map<String, dynamic> json) {
    return AdminNotification(
      id: json['_id'] as String,
      type: json['type'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      targetId: json['targetId'] as String?,
      outlet: AdminNotificationOutlet.fromJson(json['outlet']),
      isOpened: json['isOpened'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'type': type,
      'title': title,
      'content': content,
      'targetId': targetId,
      'outlet': outlet.toJson(),
      'isOpened': isOpened,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}