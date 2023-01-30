import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:divina/network/endpoints.dart';

import 'package:divina/modules/chat/widgets/list.dart';

import 'package:divina/modules/chat/chat_store.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with SingleTickerProviderStateMixin {

  ChatStore chatStore = Modular.get<ChatStore>();

  @override
  void initState() {
    super.initState();
    chatStore.tabController = TabController(vsync: this, length: 2);
    chatStore.list();
  }

  @override
  void dispose() {
    chatStore.tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light.copyWith(
          statusBarColor: Colors.transparent,
          systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
          systemNavigationBarIconBrightness: Theme.of(context).brightness == Brightness.dark ? Brightness.light : Brightness.dark
        ),
        child: Observer(
          builder: (context) {
            return Scaffold(
              extendBody: true,
              extendBodyBehindAppBar: true,
              floatingActionButton: FloatingActionButton(
                onPressed: () => Modular.to.pushNamed('/chat/user/'),
                child: const Icon(Icons.add, color: Colors.white),
              ),
              appBar: AppBar(
                titleSpacing: 0,
                title: const Padding(
                  padding: EdgeInsets.only(left: 16),
                  child: Opacity(
                    opacity: .6,
                    child: Text('Messenger', style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold))
                  ),
                ),
                automaticallyImplyLeading: false,
                bottom: TabBar(
                  controller: chatStore.tabController,
                  tabs: const [
                    Tab(
                      child: Text('Chats', style: TextStyle(fontSize: 18))
                    ),
                    Tab(
                      child: Text('Grupos', style: TextStyle(fontSize: 18))
                    )
                  ],
                )
              ),
              body: TabBarView(
                controller: chatStore.tabController,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: ListWidget(
                        data: chatStore.chats,
                        leading: (int index) => CachedNetworkImageProvider('${Endpoints.baseUrl}${chatStore.chats[index].to?.avatar_url}'),
                        isLoading: chatStore.isLoading,
                        isFetchError: chatStore.isFetchError,
                        onTap: (int index) => Modular.to.pushNamed('/chat/message/', arguments: chatStore.chats[index]),
                        onPressed: () => {},
                        onRefresh: () => chatStore.list(),
                        title: (index) => chatStore.chats[index].title,
                        subtitle: (index) => chatStore.chats[index].last_message
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 16, bottom: 16),
                      child: ListWidget(
                        data: chatStore.groupChats,
                        leading: (int index) => CachedNetworkImageProvider('${Endpoints.baseUrl}${chatStore.groupChats[index].chat_group?.avatar_url}'),
                        isLoading: chatStore.isLoading,
                        isFetchError: chatStore.isFetchError,
                        onTap: (int index) => Modular.to.pushNamed('/chat/message/', arguments: chatStore.chats[index]),
                        onPressed: () => {},
                        onRefresh: () => chatStore.list(),
                        title: (index) => chatStore.groupChats[index].chat_group?.title,
                        subtitle: (index) => chatStore.groupChats[index].chat_group?.description
                      ),
                    ),
                  ),
                ]
              )
            );
          }
        )
      )
    );
  }
}