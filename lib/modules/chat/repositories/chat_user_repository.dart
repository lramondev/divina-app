import 'dart:convert';

import 'package:divina/network/dio_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/shared/models/user_model.dart';

class ChatUserRepository {
  
  DioClient dioClient = Modular.get<DioClient>();

  Future<List<User>> list(User? from, String text) async {
    final Map<String, dynamic> queryParameters = {
      'from': jsonEncode({ "id": from?.id }),
      'text': text
    };
    final respose = await dioClient.get('system/chat_user', queryParameters: queryParameters);
    return User.fromJsonList(respose.data);
  }

}