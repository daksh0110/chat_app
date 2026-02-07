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
    final index = state.indexWhere((c) => c.id == item.id);

    if (index == -1) {
      state = [item, ...state];
      return;
    }
    final existing = state[index];
    final merged = existing.copyWith(
      name: item.name.isNotEmpty ? item.name : existing.name,
      message: item.message ?? existing.message,
      profilePic: item.profilePic ?? existing.profilePic,
      roomId: existing.roomId,
      lastMessageAt: item.lastMessageAt ?? existing.lastMessageAt,
      newMessageCount: item.newMessageCount,
    );

    final List<ChatListItem> newList = [...state];
    newList.removeAt(index);
    newList.insert(0, merged);

    state = newList;
  }

  void setRoomId({required String roomId, required String userid}) {
    final index = state.indexWhere((user) => user.id == userid);
    if (index == -1) {
      addItem(ChatListItem(id: userid, name: "", roomId: roomId));
      return;
    }

    final List<ChatListItem> newList = [...state];
    newList[index] = newList[index].copyWith(roomId: roomId);
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

  void addAll(List<ChatListItem> items) {
    state = [...state, ...items];
  }
}
