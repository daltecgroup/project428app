class IngredientHistory {
  final String id, ingredientId, userId, userName, content;
  final DateTime createdAt;

  IngredientHistory({
    required this.id,
    required this.ingredientId,
    required this.userId,
    required this.userName,
    required this.content,
    required this.createdAt,
  });

  factory IngredientHistory.fromJson(Map<String, dynamic> json) {
    return IngredientHistory(
      id: json['id'],
      ingredientId: json['ingredientId'],
      userId: json['createdBy']['userId'],
      userName: json['createdBy']['userName'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ingredientId': ingredientId,
      'createdBy': {'userId': userId, 'userName': userName},
      'content': content,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
