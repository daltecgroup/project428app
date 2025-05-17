class User {
  final String userId;
  final String name;
  List<dynamic> role = [];
  String imgUrl;

  String accessToken;
  String refreshToken;

  User(
    this.userId,
    this.name,
    this.imgUrl,
    this.accessToken,
    this.refreshToken,
  );

  User.fromJson(Map<String, dynamic> json)
    : userId = json['user']['userId'] as String,
      name = json['user']['name'] as String,
      role = json['user']['role'],
      imgUrl = json['user']['imgUrl'],
      accessToken = json['accessToken'],
      refreshToken = json['refreshToken'];
}
