
import 'package:divina/shared/models/user_model.dart';
import 'package:divina/modules/chat/models/chat_group_user_model.dart';

class ChatGroup {
  final int id;
  final String title;
  final String description;
  final String avatar_url;
  final User? owner;
  final List<ChatGroupUser>? chat_group_user;

  ChatGroup(
    this.id,
    this.title,
    this.description,
    this.avatar_url,
    this.owner,
    this.chat_group_user
  );
  
  ChatGroup.fromJson(Map<String, dynamic> json) : 
    id = json['id'],
    title = json['title'],
    description = json['description'],
    avatar_url = json['avatar_url'],
    owner = json['owner'] != null ? User.fromJson(json['owner']) : null,
    chat_group_user = json['chat_group_user'] != null ? ChatGroupUser.fromJsonList(json['chat_group_user']) : [];

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "avatar_url": avatar_url,
    "owner": owner,
    "chat_group_user": chat_group_user
  };

  static List<ChatGroup> fromJsonList(List data) {
    return data.map((item) => ChatGroup.fromJson(item)).toList();
  }
}
