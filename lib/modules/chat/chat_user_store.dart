
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:divina/modules/app/app_store.dart';

import 'package:divina/modules/chat/repositories/chat_user_repository.dart';

import 'package:divina/shared/models/api_request_model.dart';
import 'package:divina/shared/models/api_response_model.dart';
import 'package:divina/shared/models/user_model.dart';

import 'package:divina/modules/chat/models/chat_model.dart';

part 'chat_user_store.g.dart';

class ChatUserStore = ChatUserStoreBase with _$ChatUserStore;

abstract class ChatUserStoreBase with Store {

  late TabController tabController;
  ChatUserRepository chatUserRepository = ChatUserRepository();
  AppStore appStore = Modular.get<AppStore>();

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
  List<Chat> chats = [];

  @observable
  List<Chat> groupChats = [];
  
  @observable
  List<User> users = [];

  @action
  Future<List<User>> list() async {
    try {
      isFetchError = false;
      isLoading = true;
      users = await chatUserRepository.list(appStore.user, apiRequest.text);
      isLoading = false;
      return users;
    } on DioError catch (_) {
      isFetchError = true;
      isLoading = false;
      return [];
    }
  }

  @action
  void setSearching(bool value) {
    isSearching = value;
    if(value == false) apiRequest.text = '';
  }
}