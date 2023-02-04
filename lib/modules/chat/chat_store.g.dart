// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatStore on ChatStoreBase, Store {
  late final _$apiResponseAtom =
      Atom(name: 'ChatStoreBase.apiResponse', context: context);

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
      Atom(name: 'ChatStoreBase.apiRequest', context: context);

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
      Atom(name: 'ChatStoreBase.isLoading', context: context);

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
      Atom(name: 'ChatStoreBase.isSearching', context: context);

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
      Atom(name: 'ChatStoreBase.isFetchError', context: context);

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

  late final _$chatsAtom = Atom(name: 'ChatStoreBase.chats', context: context);

  @override
  ObservableList<Chat> get chats {
    _$chatsAtom.reportRead();
    return super.chats;
  }

  @override
  set chats(ObservableList<Chat> value) {
    _$chatsAtom.reportWrite(value, super.chats, () {
      super.chats = value;
    });
  }

  late final _$groupChatsAtom =
      Atom(name: 'ChatStoreBase.groupChats', context: context);

  @override
  ObservableList<Chat> get groupChats {
    _$groupChatsAtom.reportRead();
    return super.groupChats;
  }

  @override
  set groupChats(ObservableList<Chat> value) {
    _$groupChatsAtom.reportWrite(value, super.groupChats, () {
      super.groupChats = value;
    });
  }

  late final _$usersAtom = Atom(name: 'ChatStoreBase.users', context: context);

  @override
  ObservableList<User> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(ObservableList<User> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$listAsyncAction =
      AsyncAction('ChatStoreBase.list', context: context);

  @override
  Future<List<Chat>> list() {
    return _$listAsyncAction.run(() => super.list());
  }

  late final _$ChatStoreBaseActionController =
      ActionController(name: 'ChatStoreBase', context: context);

  @override
  void connect() {
    final _$actionInfo = _$ChatStoreBaseActionController.startAction(
        name: 'ChatStoreBase.connect');
    try {
      return super.connect();
    } finally {
      _$ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void disconnect() {
    final _$actionInfo = _$ChatStoreBaseActionController.startAction(
        name: 'ChatStoreBase.disconnect');
    try {
      return super.disconnect();
    } finally {
      _$ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setChats(List<Chat> newChats) {
    final _$actionInfo = _$ChatStoreBaseActionController.startAction(
        name: 'ChatStoreBase.setChats');
    try {
      return super.setChats(newChats);
    } finally {
      _$ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setGroupChats(List<Chat> newGroupChats) {
    final _$actionInfo = _$ChatStoreBaseActionController.startAction(
        name: 'ChatStoreBase.setGroupChats');
    try {
      return super.setGroupChats(newGroupChats);
    } finally {
      _$ChatStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setUsers(List<User> newUsers) {
    final _$actionInfo = _$ChatStoreBaseActionController.startAction(
        name: 'ChatStoreBase.setUsers');
    try {
      return super.setUsers(newUsers);
    } finally {
      _$ChatStoreBaseActionController.endAction(_$actionInfo);
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
chats: ${chats},
groupChats: ${groupChats},
users: ${users}
    ''';
  }
}
