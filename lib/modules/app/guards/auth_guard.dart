import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/app/app_store.dart';

class AuthGuard extends RouteGuard {
  AuthGuard() : super(redirectTo: '/login/');

  @override
  Future<bool> canActivate(String path, ModularRoute router) async {
    AppStore store = Modular.get<AppStore>();
    await store.storage.ready;
    var user = store.storage.getItem('user');
    return user != null ? true : false;
  }
}