import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:divina/network/endpoints.dart';

import 'package:divina/modules/chat/widgets/list.dart';

import 'package:divina/modules/chat/chat_user_store.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

// ABSTRAIDO EM SHARED //*********************************************************************************************** */
class Debouncer {
   Debouncer({required this.milliseconds});
   final int milliseconds;
   Timer? _timer;
   void run(VoidCallback action) {
      if (_timer?.isActive ?? false) _timer?.cancel();
      _timer = Timer(Duration(milliseconds: milliseconds), action);
   }
}

class _UserPageState extends State<UserPage> with SingleTickerProviderStateMixin {

  ChatUserStore chatUserStore = Modular.get<ChatUserStore>();

  final _focusNode = FocusNode();
  final _searchController = TextEditingController();
  final _debouncer = Debouncer(milliseconds: 1000);
  
  @override
  void initState() {
    super.initState();
    chatUserStore.list();
  }

  @override
  void dispose() {
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
              appBar: AppBar(
                title: const Text('Contatos'),
                titleSpacing: 0,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: chatUserStore.isSearching ? 
                      SizedBox(
                        width: MediaQuery.of(context).size.width - 68,
                        child: TextField(
                          controller: _searchController,
                          focusNode: _focusNode,
                          onChanged: (value) {
                            _debouncer.run(() { 
                              chatUserStore.apiRequest.text = value;
                              chatUserStore.list();
                            });
                          },
                          style: const TextStyle(fontSize: 20),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(top: 16),
                            hintText: 'Digite para pesquisar',
                            hintStyle: const TextStyle(fontSize: 16),
                            suffixIcon: IconButton(
                              icon: const Icon(Icons.close),
                              onPressed: () {
                                chatUserStore.setSearching(false);
                                if(_searchController.text.isNotEmpty) {
                                  _searchController.text = "";
                                  chatUserStore.list();
                                }
                              }
                            )
                          ),
                        ),
                      ) : 
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            chatUserStore.setSearching(true);
                            _focusNode.requestFocus();
                          }, 
                          icon: const Icon(Icons.search)
                        ),
                      )
                  )
                ],
              ),
              body: ListWidget(
                isLoading: chatUserStore.isLoading,
                isFetchError: chatUserStore.isFetchError,
                data: chatUserStore.users,
                status: (int index) => 0,
                leading: (int index) => CachedNetworkImageProvider('${Endpoints.baseUrl}${chatUserStore.users[index].avatar_url}'),
                onPressed: () => {},
                onRefresh: () => chatUserStore.list(),
                onTap: (int index) => {},
                title: (index) => chatUserStore.users[index].name,
                subtitle: (index) => chatUserStore.users[index].email
              )
            );
          }
        )
      )
    );
  }
}