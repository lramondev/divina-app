import 'dart:convert';
import 'package:divina/modules/chat/models/chat_message_model.dart';
import 'package:divina/network/dio_client.dart';
import 'package:divina/shared/models/api_response_model.dart';
import 'package:divina/shared/models/repository_response_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/chat/models/chat_model.dart';

class ChatMessageRepository {
  
  DioClient dioClient = Modular.get<DioClient>();

  Future<List<ChatMessage>> list(int page, Chat chat) async {
    final Map<String, dynamic> queryParameters = {
      'page': page.toString(),
      'chat': jsonEncode(chat)
    };
    final respose = await dioClient.get('system/chat_message', queryParameters: queryParameters);
    final ApiResponse apiResponse = ApiResponse.fromJson(respose.data);
    return ChatMessage.fromJsonList(apiResponse.data);
  }

  Future<List<RepositoryResponse>> send(Chat chat, String message, bool quoted, bool forwarded, bool media) async {
    final response = await dioClient.post('system/chat_message/send', data: { 'chat': chat, 'from': chat.from, 'message': message, 'quoted': quoted, 'forwarded': forwarded, 'media': media });
    return RepositoryResponse.fromJsonList(response.data);
  }
}