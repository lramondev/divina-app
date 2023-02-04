import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

import 'package:divina/modules/chat/models/chat_message_model.dart';

class MessageWidget extends StatelessWidget {

  ChatMessage chatMessage;

  MessageWidget({
    super.key, required this.chatMessage
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: chatMessage.sequence ? const EdgeInsets.only(left: 16, right: 16, top: 0, bottom: 4) : const EdgeInsets.only(left: 16, right: 16, top: 12, bottom: 4),
        child: Row(
          mainAxisAlignment: chatMessage.from_me ? MainAxisAlignment.end : MainAxisAlignment.start,
          children: [
            Flexible(
              child: Card(
                margin: EdgeInsets.zero,
                elevation: 2,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).brightness == Brightness.dark ? (chatMessage.from_me ? Colors.blueGrey[900] : Colors.grey[800]) : (chatMessage.from_me ? Colors.blueGrey[100] : Colors.grey[100]),
                    borderRadius: chatMessage.sequence ? const BorderRadius.all(Radius.circular(12)) : (
                      chatMessage.from_me ? const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12), topLeft: Radius.circular(12)) : 
                      const BorderRadius.only(bottomLeft: Radius.circular(12), bottomRight: Radius.circular(12), topRight: Radius.circular(12))
                    ),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                        padding: chatMessage.from_me ? const EdgeInsets.only(left: 24, right: 8, top: 8, bottom: 24) : const EdgeInsets.only(left: 8, right: 24, top: 8, bottom: 24),
                        child: Opacity(opacity: 1, child: Text(chatMessage.message, style: const TextStyle(fontSize: 16))),
                      ),
                      Positioned(
                        right: 8,
                        bottom: 4,
                        child: Opacity(opacity: .6, child: Text(DateFormat.Hm().format((DateTime.parse(chatMessage.datetime))), style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600))),
                      )
                    ],
                  )
                ),
              ),
            )
          ]
        ),
      ),
    );
  }
}