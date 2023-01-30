import 'package:divina/shared/models/user_model.dart';

class ChatGroupUser {
  final int id;
  final User usuario;

  ChatGroupUser(
    this.id,
    this.usuario
  );

  ChatGroupUser.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      usuario = User.fromJson(json['usuario']);

  static List<ChatGroupUser> fromJsonList(List data) {
    return data.map((item) => ChatGroupUser.fromJson(item)).toList();
  }
}