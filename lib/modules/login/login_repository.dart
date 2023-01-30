import 'package:dio/dio.dart';
import 'package:divina/network/dio_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginRepository {

  DioClient dioClient = Modular.get<DioClient>();
  
  Future<Response<dynamic>> login(String email, String password) async {  
    return await dioClient.post('auth/login', data: {
      'email': email,
      'password': password
    });
  }

}