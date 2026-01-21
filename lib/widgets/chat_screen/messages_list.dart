import 'package:chat_app/modal/enums/message_direction.dart';
import 'package:chat_app/modal/enums/message_status.dart';
import 'package:chat_app/modal/message_item_modal.dart';
import 'package:chat_app/widgets/chat_screen/message_item.dart';

import 'package:flutter/material.dart';

class MessagesList extends StatefulWidget {
  const MessagesList({super.key, required this.mess});
  final List<MessageItemModal> mess;

  @override
  State<MessagesList> createState() {
    return _MessageListState();
  }
}

class _MessageListState extends State<MessagesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      reverse: true,
      itemCount: widget.mess.length,
      itemBuilder: (context, index) {
        final message = widget.mess[widget.mess.length - 1 - index];
        return MessageItem(message: message);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 20),
    );
  }
}
