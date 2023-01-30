import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:divina/network/dio_client.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/nfe/models/nfe_model.dart';

import 'package:divina/shared/models/api_response_model.dart';

class NfeRepository {
  
  DioClient dioClient = Modular.get<DioClient>();

  Future<ApiResponse> list(int paginate, int page, String text) async {
    final Map<String, dynamic> queryParameters = {
      'page': page,
      'paginate': paginate,
      'text': text,
      'status_id': 1,
      'order_by[]': jsonEncode({ "column": "fiscal_nfe.datahora_emissao", "direction": "asc" })
    };
    final respose = await dioClient.get('fiscal/nfe', queryParameters: queryParameters);
    ApiResponse response = ApiResponse.fromJson(respose.data);
    return response;
  }

  Future<Response<dynamic>> approve(Nfe? nfe) async {  
    return await dioClient.post('fiscal/nfe/approve', data: nfe);
  }
}