
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import 'package:divina/modules/chat/repositories/chat_message_repository.dart';
import 'package:divina/modules/app/app_store.dart';

import 'package:divina/shared/models/api_request_model.dart';
import 'package:divina/shared/models/api_response_model.dart';
import 'package:divina/shared/models/user_model.dart';

import 'package:divina/modules/chat/models/chat_model.dart';
import 'package:divina/modules/chat/models/chat_message_model.dart';

part 'chat_message_store.g.dart';

class ChatMessageStore = ChatMessageStoreBase with _$ChatMessageStore;

abstract class ChatMessageStoreBase with Store {
  ChatMessageRepository chatMessageRepository = ChatMessageRepository();

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
  List<ChatMessage> chatMessage = [];
  
  /*
  list(params: { column: string, value: any }[]): Observable<ResponseInterface> {
    let httpParams: HttpParams = new HttpParams();
		Object.values(params).map((row) => httpParams = httpParams.set(row.column, row.value));
    return this._apiService.get('system/chat_message', httpParams)
      .pipe(map((response: ResponseInterface) => {
        return response;
      }), catchError(exception => {
        this._bottomsheetService.open(exception.error as ApiResponse[]);
        return throwError(exception);
      }));
  }

  send(chat_message: ChatMessage): Observable<ChatMessage> {
    return this._apiService.post('system/chat_message/send', chat_message)
      .pipe(map((response: ApiResponse[]) => {
        return response[0].data as ChatMessage;
      }), catchError(exception => {
        this._bottomsheetService.open(exception.error as ApiResponse[]);
        return throwError(exception);
      }));
  }
  */

  @action
  Future<List<ChatMessage>> list(Chat chat) async {
    try {
      isFetchError = false;
      isLoading = true;
      apiResponse = await chatMessageRepository.list(apiRequest.page, chat);
      isLoading = false;
      chatMessage = ChatMessage.fromJsonList(apiResponse.data);
      return chatMessage;
    } on DioError catch (_) {
      isFetchError = true;
      isLoading = false;
      return [];
    }
  }

/*
  @action
  Future<List<User>> send() async {
    try {
      isFetchError = false;
      isLoading = true;
      users = await chatUserRepository.getUsers(appStore.user, apiRequest.text);
      isLoading = false;
      return users;
    } on DioError catch (_) {
      isFetchError = true;
      isLoading = false;
      return [];
    }
  }
  */
}