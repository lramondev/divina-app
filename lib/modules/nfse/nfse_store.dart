import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:mobx/mobx.dart';

import 'package:divina/modules/nfse/nfse_repository.dart';

import 'package:divina/shared/models/api_request_model.dart';
import 'package:divina/shared/models/api_response_model.dart';
import 'package:divina/shared/models/repository_response_model.dart';
import 'package:divina/modules/nfse/models/nfse_model.dart';

part 'nfse_store.g.dart';

class NfseStore = NfseStoreBase with _$NfseStore;

abstract class NfseStoreBase with Store {
  NfseRepository nfseRepository = NfseRepository();

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
  List<Nfse> data = [];
  
  @action
  Future<List<Nfse>> list() async {
    try {
      isLoading = true;
      apiResponse = await nfseRepository.list(apiRequest.paginate, apiRequest.page, apiRequest.text);
      data = Nfse.fromJsonList(apiResponse.data);
      isLoading = false;
      return data;
    } on DioError catch (exception) {
      isLoading = false;
      return [];
    }
  }

  @action
  Future<List<RepositoryResponse>> approve(Nfse? nfse) async {
    isLoading = true;
    try {
      var response = await nfseRepository.approve(nfse);
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

  void back() {
    if(apiResponse.current_page > 1) {
      apiRequest.page--;
      list();
    }
  }
}