import 'package:chat_app/modal/enums/message_direction.dart';
import 'package:chat_app/modal/enums/message_status.dart';
import 'package:chat_app/modal/message_item_modal.dart';
import 'package:chat_app/provider/providers.dart';
import 'package:chat_app/provider/socket_providers.dart';
import 'package:chat_app/services/add_message.dart';
import 'package:chat_app/services/assignRoomId.dart';
import 'package:chat_app/services/reset_count.dart';
import 'package:chat_app/services/socket_client.dart';
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
  final ImageProvider avatar;
  final String userId;
  final String initialRoomId;

  const ChatScreen({
    super.key,
    this.userName = 'John Doe',
    this.isTyping = true,
    this.avatar = const AssetImage("assets/images/1.png"),
    required this.userId,
    this.initialRoomId = "",
  });

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late final SocketClient _socket;
  late String roomId;

  @override
  void initState() {
    super.initState();
    roomId = widget.initialRoomId;
    _socket = ref.read(socketStateProvider);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      resetUnreadCount(ref, roomId);
    });

    _socket.roomCreated(
      onRoomCreated: (roomId, userId) {
        print("reached here $roomId");
        assignRoomId(ref, roomId, userId);

        _socket.joinRoom(roomId);

        setState(() {
          this.roomId = roomId;
        });
      },
    );

    _socket.recieveMessage(
      onMessage: (from, message, messageSentAt) => addMessage(
        ref,
        roomId,
        MessageItemModal(
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          message: message,
          messageBy: MessageDirection.received,
          messageAt: messageSentAt,
          status: MessageStatus.delivered,
        ),
      ),
    );

    _socket.joinedRoom(
      onJoining: (data) {
        setState(() {
          roomId = data.roomId;
        });
      },
    );
    _socket.invitedToRoom(
      onInvitation: (data) {
        setState(() {
          roomId = data.roomId;
        });

        _socket.joinRoom(roomId);
      },
    );
  }

  @override
  void dispose() {
    _socket.removeMessageListener();
    super.dispose();
  }

  void _handleSend(String text) {
    final to = roomId.isNotEmpty ? roomId : widget.userId;
    print("this is the to$to");
    _socket.sendMessage(message: text, to: to);

    addMessage(
      ref,
      roomId,
      MessageItemModal(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        message: text,
        messageAt: DateTime.now(),
        messageBy: MessageDirection.sent,
        status: MessageStatus.sent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final messages = ref.watch(messagesProvider)[roomId] ?? [];
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
