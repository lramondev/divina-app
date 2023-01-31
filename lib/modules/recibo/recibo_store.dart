import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import 'package:divina/modules/recibo/recibo_repository.dart';

import 'package:divina/shared/models/api_request_model.dart';
import 'package:divina/shared/models/api_response_model.dart';
import 'package:divina/shared/models/repository_response_model.dart';
import 'package:divina/modules/recibo/models/recibo_model.dart';

part 'recibo_store.g.dart';

class ReciboStore = ReciboStoreBase with _$ReciboStore;

abstract class ReciboStoreBase with Store {
  ReciboRepository reciboRepository = ReciboRepository();

  @observable
  ApiResponse apiResponse = ApiResponse(0, 0, 0, 0, 0, 0, "", "", "", "", "", []);

  @observable
  ApiRequest apiRequest = ApiRequest(20, 1, "");

  @observable
  bool isLoading = false;

  @observable
  bool isSearching = false;

  @observable
  bool isFetchError = false;

  @observable
  List<Recibo> data = [];
  
  @action
  Future<List<Recibo>> list() async {
    try {
      isLoading = true;
      apiResponse = await reciboRepository.list(apiRequest.paginate, apiRequest.page, apiRequest.text);
      data = Recibo.fromJsonList(apiResponse.data);
      isLoading = false;
      return data;
    } on DioError catch (exception) {
      isLoading = false;
      return [];
    }
  }

  @action
  Future<List<RepositoryResponse>> approve(Recibo? recibo) async {
    isLoading = true;
    try {
      var response = await reciboRepository.approve(recibo);
      isLoading = false;
      return RepositoryResponse.fromJsonList(response.data);
    } on DioError catch(exception) {
      isLoading = false;
      String myJSON = exception.response.toString();
      myJSON = myJSON.replaceAll('{', '{"');
      myJSON = myJSON.replaceAll(': ', '": "');
      myJSON = myJSON.replaceAll(', ', '", "');
      myJSON = myJSON.replaceAll('}', '"}');
      return RepositoryResponse.fromJsonList(jsonDecode(myJSON));
    }
  }

  @action
  void setSearching(bool value) {
    isSearching = value;
    if(value == false) apiRequest.text = '';
  }

  @action
  void first() {
    apiRequest.page = 1;
    list();
  }

  @action
  void last() {
    apiRequest.page = apiResponse.last_page;
    list();
  }

  @action
  void next() {
    if(apiResponse.current_page < apiResponse.last_page) {
      apiRequest.page++;
      list();
    }
  }

  @action
  void back() {
    if(apiResponse.current_page > 1) {
      apiRequest.page--;
      list();
    }
  }
}