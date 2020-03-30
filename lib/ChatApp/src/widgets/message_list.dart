import 'package:flutter/material.dart';
import 'package:the_link_up/ChatApp/src/models/message.dart';

import 'message_item.dart';

class MessageList extends StatelessWidget {
  final List<Message> messages;

  MessageList({this.messages});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: messages.length,
      itemBuilder: (context, index) => MessageItem(message: messages[index]),
    );
  }
}
