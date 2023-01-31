import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/modules/core_module.dart';

import 'package:divina/modules/chat/chat_store.dart';
import 'package:divina/modules/chat/chat_message_store.dart';
import 'package:divina/modules/chat/chat_user_store.dart';

import 'package:divina/modules/chat/pages/chat_page.dart';
import 'package:divina/modules/chat/pages/message_page.dart';
import 'package:divina/modules/chat/pages/user_page.dart';

class ChatModule extends Module {

  @override
  List<Module> get imports => [
    CoreModule(),
  ];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((i) => ChatStore()),
    //Bind.lazySingleton((i) => ChatMessageStore()),
    //Bind.lazySingleton((i) => ChatUserStore())
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(Modular.initialRoute, child: (_, args) => ChatPage()),
    ChildRoute('/message/', child: (_, args) => MessagePage()),
    ChildRoute('/user/', child: (_, args) => UserPage()),
  ];
}
