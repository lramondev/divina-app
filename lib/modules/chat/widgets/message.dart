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
                    color: chatMessage.from_me ? Colors.blueGrey[700] : Colors.grey[700],
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Text(chatMessage.message, style: const TextStyle(fontSize: 18)),
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