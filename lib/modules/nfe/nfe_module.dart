import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/nfe/nfe_store.dart';

import 'package:divina/modules/nfe/pages/nfe_page.dart';
import 'package:divina/modules/nfe/pages/danfe_page.dart';
import 'package:divina/modules/nfe/pages/fatura_page.dart';
import 'package:divina/modules/nfe/pages/view_page.dart';

class NfeModule extends Module {

  @override
  List<Module> get imports => [

  ];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => NfeStore()),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => NfePage(),
    ),
    ChildRoute(
      '/view/', 
      child: (_, args) => ViewPage()
    ),
    ChildRoute(
      '/fatura/', 
      child: (_, args) => FaturaPage()
    ),
    ChildRoute(
      '/danfe/', 
      child: (_, args) => DanfePage()
    ),
  ];
}
