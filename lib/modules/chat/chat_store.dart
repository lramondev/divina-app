
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:divina/modules/chat/repositories/chat_repository.dart';
import 'package:divina/modules/chat/repositories/chat_user_repository.dart';
import 'package:divina/modules/app/app_store.dart';

import 'package:divina/shared/models/api_request_model.dart';
import 'package:divina/shared/models/api_response_model.dart';
import 'package:divina/shared/models/user_model.dart';

import 'package:divina/modules/chat/models/chat_model.dart';

part 'chat_store.g.dart';

class ChatStore = ChatStoreBase with _$ChatStore;

abstract class ChatStoreBase with Store {

  late TabController tabController;
  ChatRepository chatRepository = ChatRepository();
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
  Future<List<Chat>> list() async {
    try {
      isFetchError = false;
      isLoading = true;

      print(appStore.user);

      var c = await chatRepository.list(appStore.user, apiRequest.text);
      chats = c.where((element) => element.chat_group == null).toList();
      groupChats = c.where((element) => element.chat_group != null).toList();
      isLoading = false;
      return chats;
    } on DioError catch (_) {
      isFetchError = true;
      isLoading = false;
      return [];
    }
  }
}