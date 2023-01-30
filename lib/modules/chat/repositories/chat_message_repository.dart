import 'dart:convert';
import 'package:divina/network/dio_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/chat/models/chat_model.dart';
import 'package:divina/shared/models/api_response_model.dart';

class ChatMessageRepository {
  
  DioClient dioClient = Modular.get<DioClient>();

  Future<ApiResponse> list(int page, Chat chat) async {
    final Map<String, dynamic> queryParameters = {
      'page': page.toString(),
      'chat': jsonEncode(chat)
    };
    final respose = await dioClient.get('system/chat_message', queryParameters: queryParameters);
    ApiResponse response = ApiResponse.fromJson(respose.data);
    return response;
  }

}