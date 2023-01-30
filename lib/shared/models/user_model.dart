class User {
  final int id;
  final String name;
  final String email;
  final String? password;
  final String? token;
  final String? avatar;
  final String? avatar_url;

  User(this.id, this.name, this.email, this.password, this.token, this.avatar, this.avatar_url);

  User.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      name = json['name'],
      email = json['email'],
      password = json['password'],
      token = json['token'],
      avatar = json['avatar'],
      avatar_url = json['avatar_url'];

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "password": password,
    "token": token,
    "avatar": avatar,
    "avatar_url": avatar_url
  };

  static List<User> fromJsonList(List data) {
    return data.map((item) => User.fromJson(item)).toList();
  }
}
