class Login {
  final String id;
  final String userId;
  final String name;
  List<dynamic> role = [];
  String imgUrl;

  String accessToken;
  String refreshToken;

  Login(
    this.id,
    this.userId,
    this.name,
    this.imgUrl,
    this.accessToken,
    this.refreshToken,
  );

  Login.fromJson(Map<String, dynamic> json)
    : userId = json['user']['userId'] as String,
      id = json['user']['id'] as String,
      name = json['user']['name'] as String,
      role = json['user']['role'],
      imgUrl = json['user']['imgUrl'],
      accessToken = json['accessToken'],
      refreshToken = json['refreshToken'];
}
