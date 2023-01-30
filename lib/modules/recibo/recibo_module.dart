import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/recibo/recibo_store.dart';

import 'package:divina/modules/recibo/pages/recibo_page.dart';
import 'package:divina/modules/recibo/pages/view_page.dart';
import 'package:divina/modules/recibo/pages/fatura_page.dart';
import 'package:divina/modules/recibo/pages/pdf_page.dart';

class ReciboModule extends Module {

  @override
  List<Module> get imports => [

  ];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => ReciboStore()
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => ReciboPage(),
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
      '/pdf/', 
      child: (_, args) => PdfPage()
    ),
  ];
}
