import 'package:chat_app/modal/chat_list_item.dart';
import 'package:chat_app/provider/messages/chat_list_provider.dart';
import 'package:chat_app/provider/messages/messages_notifier.dart';
import 'package:chat_app/provider/socket_providers.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/chat_screen/chat_input_bar.dart';
import 'package:chat_app/widgets/chat_screen/messages_list.dart';
import 'package:chat_app/widgets/circle_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerStatefulWidget {
  final String userName;
  final bool isTyping;
  final String avatar;
  final String userId;

  const ChatScreen({
    super.key,
    this.userName = 'John Doe',
    this.isTyping = true,
    this.avatar = "",
    required this.userId,
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(chatListProvider.notifier).resetUnreadCount(widget.userId);

      ref.read(messagesProvider.notifier).markMessagesAsRead(widget.userId);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _handleSend(String text) {
    ref
        .read(socketStateProvider.notifier)
        .sendMessage(receiver: widget.userId, message: text);
    ref
        .read(chatListProvider.notifier)
        .addItem(
          ChatListItem(
            name: widget.userName,
            id: widget.userId,
            message: "you: $text",
            profilePic: widget.avatar,
          ),
        );

    ref
        .read(chatListProvider.notifier)
        .updateLastMessageInfo(userId: widget.userId, message: text);
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesProvider)[widget.userId] ?? [];

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
              child: CircleBubble(
                imageProvider: widget.avatar.isNotEmpty
                    ? NetworkImage(widget.avatar)
                    : const AssetImage("assets/images/1.png"),
              ),
            ),

            const SizedBox(width: 12),
            Column(
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
