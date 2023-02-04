import 'dart:async';
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

  AppStore appStore = Modular.get<AppStore>();
  ChatRepository chatRepository = ChatRepository();
  ChatUserRepository chatUserRepository = ChatUserRepository();
  IO.Socket socket = IO.io('${Endpoints.socketUrl}chat', IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

  ChatStoreBase() {
    socket.onConnect((_) => print('socket connect'));
    socket.onDisconnect((_) => { print('socket disconnect') });
    socket.on('users', (users) => setUsers(User.fromJsonList(users)));
    socket.on('typing', (chat) => print('typing'));
    connect();
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
  ObservableList<Chat> chats = ObservableList<Chat>.of([]);

  @action
  void setChats(List<Chat> newChats) {
    chats.clear();
    for (var e in newChats) {
      chats.add(e);
    }
  }

  @observable
  ObservableList<Chat> groupChats = ObservableList<Chat>.of([]);

  @action
  void setGroupChats(List<Chat> newGroupChats) {
    groupChats.clear();
    for (var e in newGroupChats) {
      groupChats.add(e);
    }
  }

  @observable
  ObservableList<User> users = ObservableList<User>.of([]);

  @action
  void setUsers(List<User> newUsers) {
    users.clear();
    for (var e in newUsers) {
      users.add(e);
    }
  }

  @action
  Future<List<Chat>> list() async {
    try {
      isFetchError = false;
      isLoading = true;
      chats.clear();
      groupChats.clear();
      var newChats = await chatRepository.list(appStore.user, apiRequest.text);
      setChats(newChats.where((element) => element.chat_group == null).toList());
      setGroupChats(newChats.where((element) => element.chat_group != null).toList());
      isLoading = false;
      return chats;
    } on DioError catch (_) {
      isFetchError = true;
      isLoading = false;
      return [];
    }
  }
}




/*
  @action
  void updateOnlineUsers(User user) {
    //onlineUsers.where((element) => element.id == user.id).
  }

  @action deleteOnlineUsers(User user) {
    onlineUsers.remove(user);
  }
*/

 /*
  @observable
  bool isTyping = false;

 
  @action
  void chatTyping(Chat chat) {

  }

  @action
  void setTyping(Chat chat) {
    if(!isTyping) {
      isTyping = true;
      socket.emit('typing', chat);
      Timer(const Duration(milliseconds: 1200), () => isTyping = false);
    }
  }
  */