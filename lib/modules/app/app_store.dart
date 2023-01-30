import 'dart:async';
import 'dart:convert';
import 'package:mobx/mobx.dart';
import 'package:localstorage/localstorage.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:divina/network/endpoints.dart';

import 'package:divina/shared/models/user_model.dart';

part 'app_store.g.dart';

class AppStore = _AppStoreBase with _$AppStore;

abstract class _AppStoreBase with Store {

  _AppStoreBase() {
    load();
    socket.onConnect((_) => print('socket connect'));
    socket.onDisconnect((_) => users = []);
    socket.on('users', (u) => users = User.fromJsonList(u));
  }

  IO.Socket socket = IO.io('${Endpoints.socketUrl}chat', IO.OptionBuilder().setTransports(['websocket']).disableAutoConnect().build());

  final LocalStorage storage = LocalStorage('app');

  @observable
  User user = User(0, "", "", "", "", "", "assets/system/resources/user/img/avatar.png");

  @observable
  List<User> users = [];

  @observable
  bool isLoading = false;

  @action
  void connect() {
    socket.io.options['query'] = { 'user': jsonEncode(user) };
    socket.connect();
  }

  @action
  void disconnect() {
    socket.io.options['query'] = { 'user': null };
    socket.disconnect();
  }

  @action
  Future<void> load() async {
    isLoading = true;
    await storage.ready;
    String? userData = storage.getItem('user');
    if(userData != null) {
      user = User.fromJson(jsonDecode(userData));
      connect();
    }
    isLoading = false;
  }

  @action
  Future<void> setUser(User u) async {
    isLoading = true;
    user = u;
    await storage.setItem('user', jsonEncode(u));
    isLoading = false;
  }

  @action
  Future<void> logout() async {
    isLoading = true;
    disconnect();
    await storage.setItem('user', null);
    await Future.delayed(const Duration(seconds: 1));
    Timer(const Duration(milliseconds: 600), () => isLoading = false);
  }

}