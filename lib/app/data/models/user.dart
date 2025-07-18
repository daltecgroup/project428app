class User {
  final String id, userId, name;
  final String? imgUrl, phone;
  final List roles;
  final DateTime createdAt, updatedAt;
  bool isActive;

  User({
    required this.id,
    required this.userId,
    required this.name,
    this.imgUrl,
    this.phone,
    this.roles = const ['operator'],
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      userId: json['userId'],
      name: json['name'],
      imgUrl: json['imgUrl'],
      phone: json['phone'],
      roles: json['roles'],
      isActive: json['isActive'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'name': name,
      'imgUrl': imgUrl,
      'phone': phone,
      'roles': roles,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  void toggleStatus() => isActive = !isActive;
}
