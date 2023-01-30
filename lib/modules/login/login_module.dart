import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/login/login_store.dart';
import 'package:divina/modules/login/login_page.dart';

class LoginModule extends Module {

  @override
  List<Module> get imports => [
    
  ];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => LoginStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, args) => LoginPage())
  ];
}
