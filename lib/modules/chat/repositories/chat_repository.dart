import 'dart:convert';

import 'package:divina/network/dio_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/shared/models/user_model.dart';

import 'package:divina/modules/chat/models/chat_model.dart';

class ChatRepository {
  
  DioClient dioClient = Modular.get<DioClient>();

  Future<List<Chat>> list(User? from, String text) async {
    final Map<String, dynamic> queryParameters = {
      'from': jsonEncode({ "id": from?.id }),
      'text': text
    };
    final respose = await dioClient.get('system/chat', queryParameters: queryParameters);
    return Chat.fromJsonList(respose.data);
  }

}