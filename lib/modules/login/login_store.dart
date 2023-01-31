
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:divina/modules/app/app_store.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:divina/modules/login/login_repository.dart';

import 'package:divina/shared/models/api_request_model.dart';
import 'package:divina/shared/models/api_response_model.dart';
import 'package:divina/shared/models/repository_response_model.dart';
import 'package:divina/shared/models/user_model.dart';

part 'login_store.g.dart';

class LoginStore = _LoginStoreBase with _$LoginStore;

abstract class _LoginStoreBase with Store {

  _LoginStoreBase() {
    setEmail(appStore.storage.getItem('email') ?? '');
    setPassword(appStore.storage.getItem('password') ?? '');
    isRememberMe = appStore.storage.getItem('rememberme') == 'true' ? true : false;
  }

  AppStore appStore = Modular.get<AppStore>();

  LoginRepository loginRepository = LoginRepository();

  @observable
  ApiRequest apiRequest = ApiRequest(20, 1, "");

  @observable
  ApiResponse apiResponse = ApiResponse(0, 0, 0, 0, 0, 0, "", "", "", "", "", []);

  @observable
  List<RepositoryResponse> repositoryResponse = [];

  @observable
  bool isLoading = false;

  @observable
  bool isRememberMe = false;

  @action
  toggleRememberMe() async {
    isRememberMe = !isRememberMe;
    await appStore.storage.setItem('rememberme', isRememberMe.toString());
  }

  @observable
  bool showPassword = false;

  @action
  void toggleShowPassword() => showPassword = !showPassword;

  @observable
  String email = "";

  @action
  void setEmail(String value) => email = value;

  @observable
  String password = "";

  @action
  void setPassword(String value) => password = value;

  @action
  Future<List<RepositoryResponse>> login() async {
    try {
      isLoading = true;
      var response = await loginRepository.login(email, password);
      appStore.login(User.fromJson(response.data[0]['data']));
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

}

