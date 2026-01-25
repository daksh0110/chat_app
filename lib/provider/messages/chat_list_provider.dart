import 'package:chat_app/modal/chat_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatListProvider = NotifierProvider<ChatListNotifier, List<ChatListItem>>(
  ChatListNotifier.new,
);

class ChatListNotifier extends Notifier<List<ChatListItem>> {
  @override
  List<ChatListItem> build() {
    return [];
  }

  void addItem(ChatListItem item) {
    final index = state.indexWhere((user) => user.id == item.id);
    final List<ChatListItem> newList = [...state];

    if (index != -1) {
      newList.removeAt(index);
    }

    newList.insert(0, item);
    state = newList;
  }

  void setRoomId({required String roomId, required String userid}) {
    final index = state.indexWhere((user) => user.id == userid);

    if (index == -1) {
      addItem(ChatListItem(id: userid, name: "", roomId: roomId));
      return;
    }

    final List<ChatListItem> newList = [...state];
    newList[index] = newList[index].assignRoomId(roomId);
    state = newList;
  }

  void resetUnreadCount(String userId) {
    final index = state.indexWhere((user) => user.id == userId);
    if (index == -1) return;

    final List<ChatListItem> newList = [...state];
    newList[index] = newList[index].resetCount();
    state = newList;
  }

  void updateLastMessageInfo({
    required String userId,
    required String message,
    bool isReceived = false,
  }) {
    final lastMessage = isReceived ? message : "you: $message";
    final DateTime time = DateTime.now();

    final index = state.indexWhere((user) => user.id == userId);

    if (index == -1) {
      addItem(
        ChatListItem(
          id: userId,
          name: "",
          message: lastMessage,
          lastMessageAt: time,
          newMessageCount: isReceived ? 1 : 0,
        ),
      );
      return;
    }

    final List<ChatListItem> newList = [...state];
    final current = newList[index];

    newList[index] = current.copyWith(
      message: lastMessage,
      lastMessageAt: time,
      newMessageCount: isReceived
          ? current.newMessageCount + 1
          : current.newMessageCount,
    );

    state = newList;
  }
}
