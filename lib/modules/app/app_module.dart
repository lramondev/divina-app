import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/core_module.dart';
import 'package:divina/modules/home/home_module.dart';
import 'package:divina/modules/login/login_module.dart';
import 'package:divina/modules/chat/chat_module.dart';
import 'package:divina/modules/nfe/nfe_module.dart';
import 'package:divina/modules/nfse/nfse_module.dart';
import 'package:divina/modules/recibo/recibo_module.dart';

import 'package:divina/modules/app/guards/auth_guard.dart';
import 'package:divina/modules/app/app_store.dart';

class AppModule extends Module {

  @override
  List<Module> get imports => [
    CoreModule(),
  ];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => AppStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(
      Modular.initialRoute,
      module: HomeModule(),
      guards: [ 
        AuthGuard() 
      ]
    ),
    ModuleRoute(
      '/home/',
      module: HomeModule(),
    ),
    ModuleRoute(
      '/login/',
      module: LoginModule(),
    ),
    ModuleRoute(
      '/chat/',
      module: ChatModule(),
    ),
    ModuleRoute(
      '/nfe/',
      module: NfeModule(),
    ),
    ModuleRoute(
      '/nfse/',
      module: NfseModule(),
    ),
    ModuleRoute(
      '/recibo/',
      module: ReciboModule(),
    ),
  ];
}
