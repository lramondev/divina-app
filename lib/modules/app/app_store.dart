import 'dart:async';
import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:localstorage/localstorage.dart';


import 'package:divina/shared/models/user_model.dart';

part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {

  _AppStoreBase() {
    load();
  }

  final LocalStorage storage = LocalStorage('app');

  @observable
  bool isLoading = false;

  @observable
  User user = User(0, "", "", "", "", "", "assets/system/resources/user/img/avatar.png", false);

  @action
  Future<void> load() async {
    isLoading = true;
    await storage.ready;
    String? userData = storage.getItem('user');
    if(userData != null) {
      user = User.fromJson(jsonDecode(userData));
      print('load with user');
    } else {
      print('load without user');
    }
    isLoading = false;
  }

  @action
  Future<void> login(User u) async {
    print('login');
    isLoading = true;
    user = u;
    await storage.setItem('user', jsonEncode(u));
    isLoading = false;
  }

  @action
  Future<void> logout() async {
    print('logout');
    isLoading = true;
    await storage.setItem('user', null);
    await Future.delayed(const Duration(seconds: 1));
    Timer(const Duration(milliseconds: 600), () => isLoading = false);
  }

}