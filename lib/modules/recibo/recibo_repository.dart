import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:divina/network/dio_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/recibo/models/recibo_model.dart';

import 'package:divina/shared/models/api_response_model.dart';

class ReciboRepository {
  
  DioClient dioClient = Modular.get<DioClient>();

  Future<ApiResponse> list(int paginate, int page, String text) async {
    final Map<String, dynamic> queryParameters = {
      'page': page,
      'paginate': paginate,
      'text': text,
      'status_id': 1,
      'order_by[]': jsonEncode({ "column": "fiscal_recibo.datahora_emissao", "direction": "asc" })
    };
    final respose = await dioClient.get('fiscal/recibo', queryParameters: queryParameters);
    ApiResponse response = ApiResponse.fromJson(respose.data);
    return response;
  }

  Future<Response<dynamic>> approve(Recibo? recibo) async {  
    return await dioClient.post('fiscal/recibo/approve', data: recibo);
  }
}