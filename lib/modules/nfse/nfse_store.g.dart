// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nfse_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$NfseStore on NfseStoreBase, Store {
  late final _$apiResponseAtom =
      Atom(name: 'NfseStoreBase.apiResponse', context: context);

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
      Atom(name: 'NfseStoreBase.apiRequest', context: context);

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
      Atom(name: 'NfseStoreBase.isLoading', context: context);

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
      Atom(name: 'NfseStoreBase.isSearching', context: context);

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
      Atom(name: 'NfseStoreBase.isFetchError', context: context);

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

  late final _$dataAtom = Atom(name: 'NfseStoreBase.data', context: context);

  @override
  List<Nfse> get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(List<Nfse> value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  late final _$listAsyncAction =
      AsyncAction('NfseStoreBase.list', context: context);

  @override
  Future<List<Nfse>> list() {
    return _$listAsyncAction.run(() => super.list());
  }

  late final _$approveAsyncAction =
      AsyncAction('NfseStoreBase.approve', context: context);

  @override
  Future<List<RepositoryResponse>> approve(Nfse? nfse) {
    return _$approveAsyncAction.run(() => super.approve(nfse));
  }

  late final _$NfseStoreBaseActionController =
      ActionController(name: 'NfseStoreBase', context: context);

  @override
  void setSearching(bool value) {
    final _$actionInfo = _$NfseStoreBaseActionController.startAction(
        name: 'NfseStoreBase.setSearching');
    try {
      return super.setSearching(value);
    } finally {
      _$NfseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void first() {
    final _$actionInfo = _$NfseStoreBaseActionController.startAction(
        name: 'NfseStoreBase.first');
    try {
      return super.first();
    } finally {
      _$NfseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void last() {
    final _$actionInfo =
        _$NfseStoreBaseActionController.startAction(name: 'NfseStoreBase.last');
    try {
      return super.last();
    } finally {
      _$NfseStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void next() {
    final _$actionInfo =
        _$NfseStoreBaseActionController.startAction(name: 'NfseStoreBase.next');
    try {
      return super.next();
    } finally {
      _$NfseStoreBaseActionController.endAction(_$actionInfo);
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
