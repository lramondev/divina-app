import 'package:divina/shared/models/user_model.dart';
import 'package:divina/modules/chat/models/chat_group_model.dart';

class Chat {
  final int id;
  final String title;
  final User from;
  final User? to;
  final ChatGroup? chat_group;
  final bool pinned;
  final int unread;
  final String? last_message;
  final String datetime;

  Chat(
    this.id, 
    this.title,
    this.from,
    this.to,
    this.chat_group,
    this.pinned,
    this.unread,
    this.last_message,
    this.datetime
  );

  Chat.fromJson(Map<String, dynamic> json) : 
    id = json['id'],
    title = json['title'],
    from = User.fromJson(json['from']),
    to = json['to'] != null ? User.fromJson(json['to']) : null,
    chat_group = json['chat_group'] != null ? ChatGroup.fromJson(json['chat_group']) : null,
    pinned = json['pinned'],
    unread = json['unread'],
    last_message = json['last_message'],
    datetime = json['datetime'];

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "from": from,
    "to": to,
    "chat_group": chat_group,
    "pinned": pinned,
    "unread": unread,
    "last_message": last_message,
    "datetime": datetime
  };

  static List<Chat> fromJsonList(List data) {
    return data.map((item) => Chat.fromJson(item)).toList();
  }
}
