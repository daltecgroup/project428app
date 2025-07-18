class PromoSetting {
  final String id, code, title;
  final String? description;
  final bool isActive;
  final double bonusMaxPrice, nominal;
  final DateTime createdAt, updatedAt;

  PromoSetting({
    required this.id,
    required this.code,
    required this.title,
    this.description,
    required this.isActive,
    required this.bonusMaxPrice,
    required this.nominal,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PromoSetting.fromJson(Map<String, dynamic> json) {
    return PromoSetting(
      id: json['id'] as String,
      code: json['code'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      isActive: json['isActive'] as bool,
      bonusMaxPrice: (json['bonusMaxPrice'] as num).toDouble(),
      nominal: (json['nominal'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'description': description,
      'is_active': isActive,
      'bonus_max_price': bonusMaxPrice,
      'nominal': nominal,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
    };
  }
}
