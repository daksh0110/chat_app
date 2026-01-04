import 'package:chat_app/modal/chat_litst_item.dart';
import 'package:chat_app/modal/enums/message_direction.dart';
import 'package:chat_app/modal/enums/message_status.dart';
import 'package:chat_app/modal/message_item_modal.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/chat_screen/chat_input_bar.dart';
import 'package:chat_app/widgets/chat_screen/messages_list.dart';
import 'package:chat_app/widgets/circle_bubble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  final String userName;
  final bool isTyping;
  final ImageProvider avatar;

  const ChatScreen({
    super.key,
    this.userName = 'John Doe',
    this.isTyping = true,
    this.avatar = const AssetImage("assets/images/1.png"),
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final List<MessageItemModal> messages = [];

  void _handleSend(String text) {
    setState(() {
      messages.insert(
        0,
        MessageItemModal(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          message: text,
          messageAt: DateTime.now(),
          messageBy: MessageDirection.sent,
          status: MessageStatus.sent,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: AppColors.placeholderTextColor.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        titleSpacing: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_ios),
        ),
        title: Row(
          children: [
            SizedBox(
              height: 48,
              width: 48,
              child: CircleBubble(imageProvider: widget.avatar),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    widget.userName,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMediumColor,
                  ),
                  const SizedBox(height: 2),
                  AppText(
                    widget.isTyping ? 'typing...' : 'online',
                    color: AppColors.placeholderTextColor,
                    fontSize: 14,
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            children: [
              Expanded(child: MessagesList(mess: messages)),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ChatInputBar(onSend: _handleSend),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
