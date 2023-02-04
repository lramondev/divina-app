
import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:divina/shared/models/user_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:divina/network/endpoints.dart';

import 'package:divina/modules/chat/repositories/chat_message_repository.dart';
import 'package:divina/modules/app/app_store.dart';

import 'package:divina/shared/models/api_request_model.dart';
import 'package:divina/shared/models/api_response_model.dart';

import 'package:divina/modules/chat/models/chat_model.dart';
import 'package:divina/modules/chat/models/chat_message_model.dart';

part 'chat_message_store.g.dart';

class ChatMessageStore = ChatMessageStoreBase with _$ChatMessageStore;

abstract class ChatMessageStoreBase with Store {
  
  AppStore appStore = Modular.get<AppStore>();
  ChatMessageRepository chatMessageRepository = ChatMessageRepository();
  IO.Socket socket = IO.io('${Endpoints.socketUrl}chat_message', IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

  ChatMessageStoreBase() {
    socket.onConnect((_) => print('socket connect'));
    socket.onDisconnect((_) => print('socket disconnect'));
    socket.on('chat_message', (data) => setChatMessage(ChatMessage.fromJson(data)));
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
  ObservableList<ChatMessage> chatMessages = ObservableList<ChatMessage>.of([]);

  @action
  void setChatMessage(ChatMessage chatMessage) {
    print('setChatMessage');
    chatMessages.add(chatMessage);
  }

  @action
  void setChatMessages(List<ChatMessage> newChatMessages) {
    chatMessages.clear();
    for (var e in newChatMessages) {
      chatMessages.insert(0, e);
    }
  }

  @action
  Future<List<ChatMessage>> list(Chat chat) async {
    try {
      isFetchError = false;
      isLoading = true;
      var newChatMessages = await chatMessageRepository.list(apiRequest.page, chat);
      setChatMessages(newChatMessages);
      isLoading = false;
      return newChatMessages;
    } on DioError catch (_) {
      isFetchError = true;
      isLoading = false;
      return [];
    }
  }

  @action
  Future<void> send(Chat chat, String message) async {
    try {
      await chatMessageRepository.send(chat, message, false, false, false);
      isLoading = false;
    } on DioError catch (_) {
      
    }
  }
}