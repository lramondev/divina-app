import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/network/dio_client.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => DioClient(Dio()), export: true),
  ];

  @override
  final List<ModularRoute> routes = [];
}
