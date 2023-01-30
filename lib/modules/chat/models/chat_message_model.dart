import 'package:divina/modules/chat/models/chat_model.dart';
import 'package:divina/shared/models/user_model.dart';

class ChatMessage {
  final int id;
  final Chat chat;
  final String message;
  final User from;
  final bool from_me;
  final bool unread;
  final bool quoted;
  final bool? forwarded;
  final bool media;
  final bool sequence;
  final String datetime;

  ChatMessage(
    this.id,
    this.chat,
    this.message,
    this.from,
    this.from_me,
    this.unread,
    this.quoted,
    this.forwarded,
    this.media,
    this.sequence,
    this.datetime
  );

  ChatMessage.fromJson(Map<String, dynamic> json) : 
    id = json['id'],
    chat = Chat.fromJson(json['chat']),
    message = json['message'],
    from = User.fromJson(json['from']),
    from_me = json['from_me'],
    unread = json['unread'],
    quoted = json['quoted'],
    forwarded = json['forwarde'],
    media = json['media'],
    sequence = json['sequence'],
    datetime = json['datetime'];

  Map<String, dynamic> toJson() => {
    "id": id,
    "chat": chat,
    "message": message,
    "from": from,
    "from_me": from_me,
    "unread": unread,
    "quoted": quoted,
    "forwarded": forwarded,
    "media": media,
    "sequence": sequence,
    "datetime": datetime
  };

  static List<ChatMessage> fromJsonList(List data) {
    return data.map((item) => ChatMessage.fromJson(item)).toList();
  }
}