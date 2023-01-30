import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/network/endpoints.dart';

import 'package:divina/modules/chat/chat_message_store.dart';

import 'package:divina/modules/chat/models/chat_model.dart';
import 'package:divina/modules/chat/models/chat_message_model.dart';

import 'package:divina/modules/chat/widgets/message.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  ChatMessageStore chatMessageStore = Modular.get<ChatMessageStore>();
  late Chat chat;

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    if (ModalRoute.of(context)!.settings.arguments != null) {
      chat = ModalRoute.of(context)!.settings.arguments as Chat;
      chatMessageStore.list(chat);
    }
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark
      ),
      child: Observer(
        builder: (BuildContext context) { 
          return Scaffold(
            appBar: AppBar(
              titleSpacing: 0,
              title: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 0, right: 12),
                    child: CircleAvatar(backgroundImage: NetworkImage('${Endpoints.baseUrl}${ chat.chat_group != null ? chat.chat_group!.avatar_url : chat.to!.avatar_url }'), radius: 20),
                  ),
                  Flexible(child: Text(chat.chat_group != null ? chat.chat_group!.title : chat.title, style: const TextStyle(fontSize: 20), overflow: TextOverflow.ellipsis))
                ],
              ),
            ),
            body: Stack(
              children: [
                Positioned(
                  top: 0,
                  bottom: 64,
                  left: 0,
                  right: 0,
                  child: SingleChildScrollView(
                    child: Column(
                      children: chatMessageStore.chatMessage.reversed.map((e) => MessageWidget(chatMessage: e)).toList(),
                    ),
                  ),
                ),
                Positioned(
                  height: 64,
                  width: MediaQuery.of(context).size.width,
                  bottom: 0,
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8, right: 4),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width - 72,
                          child: TextField(
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.blueAccent,
                              hintText: 'Digite para conversar',
                              contentPadding: const EdgeInsets.all(2),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32),
                              )
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 4, right: 8),
                        child: IconButton(
                          icon: const Icon(Icons.mic),
                          iconSize: 32,
                          onPressed: () => {},
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.resolveWith((states) {
                              return Theme.of(context).floatingActionButtonTheme.backgroundColor;
                            }),
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        }
      )
    );
  }
}