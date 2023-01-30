import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/nfse/nfse_store.dart';

import 'package:divina/modules/nfse/pages/nfse_page.dart';
import 'package:divina/modules/nfse/pages/view_page.dart';
import 'package:divina/modules/nfse/pages/fatura_page.dart';
import 'package:divina/modules/nfse/pages/pdf_page.dart';

class NfseModule extends Module {

  @override
  List<Module> get imports => [

  ];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => NfseStore()
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      Modular.initialRoute,
      child: (_, args) => NfsePage(),
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
