// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_user_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ChatUserStore on ChatUserStoreBase, Store {
  late final _$apiResponseAtom =
      Atom(name: 'ChatUserStoreBase.apiResponse', context: context);

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
      Atom(name: 'ChatUserStoreBase.apiRequest', context: context);

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
      Atom(name: 'ChatUserStoreBase.isLoading', context: context);

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
      Atom(name: 'ChatUserStoreBase.isSearching', context: context);

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
      Atom(name: 'ChatUserStoreBase.isFetchError', context: context);

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

  late final _$chatsAtom =
      Atom(name: 'ChatUserStoreBase.chats', context: context);

  @override
  List<Chat> get chats {
    _$chatsAtom.reportRead();
    return super.chats;
  }

  @override
  set chats(List<Chat> value) {
    _$chatsAtom.reportWrite(value, super.chats, () {
      super.chats = value;
    });
  }

  late final _$groupChatsAtom =
      Atom(name: 'ChatUserStoreBase.groupChats', context: context);

  @override
  List<Chat> get groupChats {
    _$groupChatsAtom.reportRead();
    return super.groupChats;
  }

  @override
  set groupChats(List<Chat> value) {
    _$groupChatsAtom.reportWrite(value, super.groupChats, () {
      super.groupChats = value;
    });
  }

  late final _$usersAtom =
      Atom(name: 'ChatUserStoreBase.users', context: context);

  @override
  List<User> get users {
    _$usersAtom.reportRead();
    return super.users;
  }

  @override
  set users(List<User> value) {
    _$usersAtom.reportWrite(value, super.users, () {
      super.users = value;
    });
  }

  late final _$listAsyncAction =
      AsyncAction('ChatUserStoreBase.list', context: context);

  @override
  Future<List<User>> list() {
    return _$listAsyncAction.run(() => super.list());
  }

  late final _$ChatUserStoreBaseActionController =
      ActionController(name: 'ChatUserStoreBase', context: context);

  @override
  void setSearching(bool value) {
    final _$actionInfo = _$ChatUserStoreBaseActionController.startAction(
        name: 'ChatUserStoreBase.setSearching');
    try {
      return super.setSearching(value);
    } finally {
      _$ChatUserStoreBaseActionController.endAction(_$actionInfo);
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
