import 'package:chat_app/modal/chat_list_item.dart';

import 'package:chat_app/modal/message_item_modal.dart';
import 'package:chat_app/provider/messages/chat_list_provider.dart';
import 'package:chat_app/provider/messages/messages_notifier.dart';
import 'package:chat_app/services/socket_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final socketStateProvider = NotifierProvider<SocketNotifier, SocketClient?>(
  SocketNotifier.new,
);

class SocketNotifier extends Notifier<SocketClient?> {
  SocketClient? _socket;

  @override
  SocketClient? build() {
    ref.onDispose(_disposeSocket);
    return null;
  }

  Future<void> connect(String token) async {
    if (_socket != null) return;

    final socket = SocketClient();
    await socket.createSocketConnection(token);
    _socket = socket;
    state = socket;
    _registerListeners();
    _invitedToRoom();
    _roomCreated();
  }

  void sendMessage({required String receiver, required String message}) {
    final msg = MessageItemModal(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      message: message,
      messageAt: DateTime.now(),
      messageBy: MessageDirection.sent,
      status: MessageStatus.sent,
    );

    ref.read(messagesProvider.notifier).addMessage(receiver, msg);

    final chats = ref.read(chatListProvider);
    final index = chats.indexWhere((c) => c.id == receiver);

    final roomId = index != -1 && chats[index].roomId.isNotEmpty
        ? chats[index].roomId
        : null;
    _socket?.sendMessage(receiver: receiver, message: message, roomId: roomId);
  }

  void _invitedToRoom() {
    _socket?.invitedToRoom(
      onInvitation: (data) {
        final user = ChatListItem(
          name: data.name,
          id: data.from,
          lastMessageAt: data.messageSentAt,
          message: data.message ?? "",
          newMessageCount: 1,
          roomId: data.roomId,
          profilePic: data.profilePic ?? "",
        );
        ref.read(chatListProvider.notifier).addItem(user);
        final msg = MessageItemModal(
          id: data.messageSentAt.microsecondsSinceEpoch.toString(),
          message: data.message ?? "",
          messageBy: MessageDirection.received,
          messageAt: data.messageSentAt,
          status: MessageStatus.delivered,
        );
        ref.read(messagesProvider.notifier).addMessage(data.from, msg);
      },
    );
  }

  void _registerListeners() {
    _socket?.recieveMessage(
      onMessage: (from, message, sentAt) {
        final msg = MessageItemModal(
          id: sentAt.millisecondsSinceEpoch.toString(),
          message: message,
          messageAt: sentAt,
          messageBy: MessageDirection.received,
          status: MessageStatus.delivered,
        );
        ref.read(messagesProvider.notifier).addMessage(from, msg);
        ref
            .read(chatListProvider.notifier)
            .updateLastMessageInfo(
              userId: from,
              message: message,
              isReceived: true,
            );
      },
    );
  }

  void _roomCreated() {
    _socket?.roomCreated(
      onRoomCreated: (roomId, userId) {
        ref
            .read(chatListProvider.notifier)
            .setRoomId(roomId: roomId, userid: userId);
      },
    );
  }

  void disconnect() {
    _disposeSocket();
    state = null;
  }

  void _disposeSocket() {
    _socket?.disconnect();
    _socket = null;
  }
}
