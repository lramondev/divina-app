import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:divina/network/endpoints.dart';

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

  ChatStoreBase() {
    socket.onConnect((_) => print('socket connect'));
    socket.onDisconnect((_) => { users = [], print('socket disconnect') });
    socket.on('users', (chatUsers) => setChatUsers(chatUsers));
    connect();
  }

  IO.Socket socket = IO.io('${Endpoints.socketUrl}chat', IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

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

  @observable
  List<User> chatUsers = [];

  @action
  void setChatUsers(dynamic newChatUsers) {
    chatUsers = User.fromJsonList(newChatUsers);
    print(chatUsers.length);
  }

  @action
  void toggle() {
    chatUsers = User.fromJsonList(jsonDecode(jsonEncode(chatUsers)));
  }

  @action
  void connect() {
    socket.io.options['query'] = { 'user': jsonEncode(appStore.user) };
    socket.connect();
  }

  @action
  void disconnect() {
    socket.io.options['query'] = { 'user': null };
    socket.disconnect();
  }

  @action
  Future<List<Chat>> list() async {
    try {
      isFetchError = false;
      isLoading = true;
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