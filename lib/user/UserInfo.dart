class User {
  final String loginId;
  final String password;
  final String nickname;

  User({
    required this.loginId,
    required this.password,
    required this.nickname,
  });

  String getId() {
    return loginId;
  }

  String getPassword() {
    return password;
  }

  String getNickname() {
    return nickname;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        loginId: json['loginId'],
        password: json['password'],
        nickname: json['nickname']);
  }

  Map<String, dynamic> toJson() => {
        'nickname': nickname,
        'password': password,
        'loginId': loginId,
      };
}
