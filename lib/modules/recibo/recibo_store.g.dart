// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recibo_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ReciboStore on ReciboStoreBase, Store {
  late final _$apiResponseAtom =
      Atom(name: 'ReciboStoreBase.apiResponse', context: context);

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
      Atom(name: 'ReciboStoreBase.apiRequest', context: context);

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
      Atom(name: 'ReciboStoreBase.isLoading', context: context);

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
      Atom(name: 'ReciboStoreBase.isSearching', context: context);

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
      Atom(name: 'ReciboStoreBase.isFetchError', context: context);

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

  late final _$dataAtom = Atom(name: 'ReciboStoreBase.data', context: context);

  @override
  List<Recibo> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(List<Recibo> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$listAsyncAction =
      AsyncAction('ReciboStoreBase.list', context: context);

  @override
  Future<List<Recibo>> list() {
    return _$listAsyncAction.run(() => super.list());
  }

  late final _$approveAsyncAction =
      AsyncAction('ReciboStoreBase.approve', context: context);

  @override
  Future<List<RepositoryResponse>> approve(Recibo? recibo) {
    return _$approveAsyncAction.run(() => super.approve(recibo));
  }

  late final _$ReciboStoreBaseActionController =
      ActionController(name: 'ReciboStoreBase', context: context);

  @override
  void setSearching(bool value) {
    final _$actionInfo = _$ReciboStoreBaseActionController.startAction(
        name: 'ReciboStoreBase.setSearching');
    try {
      return super.setSearching(value);
    } finally {
      _$ReciboStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void first() {
    final _$actionInfo = _$ReciboStoreBaseActionController.startAction(
        name: 'ReciboStoreBase.first');
    try {
      return super.first();
    } finally {
      _$ReciboStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void last() {
    final _$actionInfo = _$ReciboStoreBaseActionController.startAction(
        name: 'ReciboStoreBase.last');
    try {
      return super.last();
    } finally {
      _$ReciboStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void next() {
    final _$actionInfo = _$ReciboStoreBaseActionController.startAction(
        name: 'ReciboStoreBase.next');
    try {
      return super.next();
    } finally {
      _$ReciboStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void back() {
    final _$actionInfo = _$ReciboStoreBaseActionController.startAction(
        name: 'ReciboStoreBase.back');
    try {
      return super.back();
    } finally {
      _$ReciboStoreBaseActionController.endAction(_$actionInfo);
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
data: ${data}
    ''';
  }
}
