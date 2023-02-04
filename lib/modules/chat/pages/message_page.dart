import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/network/endpoints.dart';

import 'package:divina/modules/chat/chat_message_store.dart';

import 'package:divina/modules/chat/models/chat_model.dart';

import 'package:divina/modules/chat/widgets/message.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {

  ChatMessageStore chatMessageStore = Modular.get<ChatMessageStore>();
  TextEditingController textController = TextEditingController();
  late Chat chat;

  @override
  void initState() {
    super.initState();
    chatMessageStore.connect();
  }

  @override
  void dispose() {
    super.dispose();
    chatMessageStore.disconnect();
  }
  
  @override
  Widget build(BuildContext context) {
    
    if (ModalRoute.of(context)!.settings.arguments != null) {
      chat = ModalRoute.of(context)!.settings.arguments as Chat;
      chatMessageStore.list(chat);
    }
    
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: Theme.of(context).brightness == Brightness.dark ? SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.light
      ) : SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.dark
      ),
      child: Observer(
        builder: (BuildContext context) { 
          return chatMessageStore.isLoading ? 
            const Scaffold(body: Center(child: CircularProgressIndicator())) : 
            Scaffold(
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
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 48,
                    child: ListView.builder(
                      itemCount: chatMessageStore.chatMessages.length,
                      itemBuilder: (context, index) => Observer(builder: (_) => MessageWidget(chatMessage: chatMessageStore.chatMessages[index]))
                    ),
                  ),
                  Positioned(
                    height: 48,
                    width: MediaQuery.of(context).size.width,
                    bottom: 0,
                    child: Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 8),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).secondaryHeaderColor,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.emoji_emotions_outlined), 
                                  onPressed: () {}
                                ),
                                Expanded(
                                  child: TextField(
                                    controller: textController,
                                    decoration: const InputDecoration(
                                    hintText: "Digite para conversar...",
                                    border: InputBorder.none),
                                  ),
                                ),
                                IconButton(
                                  icon: const Icon(Icons.attach_file),
                                  onPressed: () {},
                                ),
                                IconButton(
                                  icon: const Icon(Icons.photo_camera),
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).floatingActionButtonTheme.backgroundColor, 
                            shape: BoxShape.circle
                          ),
                          child: InkWell(
                            child: const Icon(
                              Icons.keyboard_voice,
                              color: Colors.white,
                            ),
                            onTap: () {
                              chatMessageStore.send(chat, textController.text);
                              textController.text = '';
                            },
                            onLongPress: () {
                              
                            },
                          ),
                        ),
                      )
                    ],
                  )
                )
              ],
            ),
          );
        }
      )
    );
  }
}
