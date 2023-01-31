
import 'dart:async';
import 'package:flutter/material.dart';

class Debouncer {
   Debouncer({required this.milliseconds});
   final int milliseconds;
   Timer? _timer;
   void run(VoidCallback action) {
      if (_timer?.isActive ?? false) _timer?.cancel();
      _timer = Timer(Duration(milliseconds: milliseconds), action);
   }
}

class ToolBar extends StatelessWidget with PreferredSizeWidget {
 
  Debouncer debouncer = Debouncer(milliseconds: 1000);
  FocusNode focusNode = FocusNode();

  bool isSearching = false;

  String title;
  Function(bool value) setSearching;
  Function(String value) search;
  TextEditingController controller;

  ToolBar({ 
    super.key, 
    required this.title,
    required this.isSearching, 
    required this.setSearching,
    required this.search,
    required this.controller
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      titleSpacing: 0,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: isSearching ? 
            SizedBox(
              width: MediaQuery.of(context).size.width - 68,
              child: TextField(
                controller: controller,
                focusNode: focusNode,
                onChanged: (value) {
                  debouncer.run(() => search(value));
                },
                style: const TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.only(top: 18),
                  hintText: 'Digite para pesquisar',
                  hintStyle: const TextStyle(fontSize: 16),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      setSearching(false);
                      if(controller.text.isNotEmpty) {
                        search("");
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
                  setSearching(true);
                  focusNode.requestFocus();
                }, 
                icon: const Icon(Icons.search)
              ),
            )
        )
      ],
    );
  }
}