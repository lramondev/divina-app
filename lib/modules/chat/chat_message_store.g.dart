// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatMessageStore on ChatMessageStoreBase, Store {
  late final _$apiResponseAtom =
      Atom(name: 'ChatMessageStoreBase.apiResponse', context: context);

  @override
  ApiResponse get apiResponse {
    _$apiResponseAtom.reportRead();
    return super.apiResponse;
  }

  @override
  set apiResponse(ApiResponse value) {
    _$apiResponseAtom.reportWrite(value, super.apiResponse, () {
      super.apiResponse = value;
    });
  }

  late final _$apiRequestAtom =
      Atom(name: 'ChatMessageStoreBase.apiRequest', context: context);

  @override
  ApiRequest get apiRequest {
    _$apiRequestAtom.reportRead();
    return super.apiRequest;
  }

  @override
  set apiRequest(ApiRequest value) {
    _$apiRequestAtom.reportWrite(value, super.apiRequest, () {
      super.apiRequest = value;
    });
  }

  late final _$isLoadingAtom =
      Atom(name: 'ChatMessageStoreBase.isLoading', context: context);

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  late final _$isSearchingAtom =
      Atom(name: 'ChatMessageStoreBase.isSearching', context: context);

  @override
  bool get isSearching {
    _$isSearchingAtom.reportRead();
    return super.isSearching;
  }

  @override
  set isSearching(bool value) {
    _$isSearchingAtom.reportWrite(value, super.isSearching, () {
      super.isSearching = value;
    });
  }

  late final _$isFetchErrorAtom =
      Atom(name: 'ChatMessageStoreBase.isFetchError', context: context);

  @override
  bool get isFetchError {
    _$isFetchErrorAtom.reportRead();
    return super.isFetchError;
  }

  @override
  set isFetchError(bool value) {
    _$isFetchErrorAtom.reportWrite(value, super.isFetchError, () {
      super.isFetchError = value;
    });
  }

  late final _$chatMessagesAtom =
      Atom(name: 'ChatMessageStoreBase.chatMessages', context: context);

  @override
  ObservableList<ChatMessage> get chatMessages {
    _$chatMessagesAtom.reportRead();
    return super.chatMessages;
  }

  @override
  set chatMessages(ObservableList<ChatMessage> value) {
    _$chatMessagesAtom.reportWrite(value, super.chatMessages, () {
      super.chatMessages = value;
    });
  }

  late final _$listAsyncAction =
      AsyncAction('ChatMessageStoreBase.list', context: context);

  @override
  Future<List<ChatMessage>> list(Chat chat) {
    return _$listAsyncAction.run(() => super.list(chat));
  }

  late final _$sendAsyncAction =
      AsyncAction('ChatMessageStoreBase.send', context: context);

  @override
  Future<void> send(Chat chat, String message) {
    return _$sendAsyncAction.run(() => super.send(chat, message));
  }

  late final _$ChatMessageStoreBaseActionController =
      ActionController(name: 'ChatMessageStoreBase', context: context);

  @override
  void connect() {
    final _$actionInfo = _$ChatMessageStoreBaseActionController.startAction(
        name: 'ChatMessageStoreBase.connect');
    try {
      return super.connect();
    } finally {
      _$ChatMessageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disconnect() {
    final _$actionInfo = _$ChatMessageStoreBaseActionController.startAction(
        name: 'ChatMessageStoreBase.disconnect');
    try {
      return super.disconnect();
    } finally {
      _$ChatMessageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChatMessage(ChatMessage chatMessage) {
    final _$actionInfo = _$ChatMessageStoreBaseActionController.startAction(
        name: 'ChatMessageStoreBase.setChatMessage');
    try {
      return super.setChatMessage(chatMessage);
    } finally {
      _$ChatMessageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChatMessages(List<ChatMessage> newChatMessages) {
    final _$actionInfo = _$ChatMessageStoreBaseActionController.startAction(
        name: 'ChatMessageStoreBase.setChatMessages');
    try {
      return super.setChatMessages(newChatMessages);
    } finally {
      _$ChatMessageStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
apiResponse: ${apiResponse},
apiRequest: ${apiRequest},
isLoading: ${isLoading},
isSearching: ${isSearching},
isFetchError: ${isFetchError},
chatMessages: ${chatMessages}
    ''';
  }
}
