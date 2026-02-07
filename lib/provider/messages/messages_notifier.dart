import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/modal/message_item_modal.dart';

final messagesProvider =
    NotifierProvider<MessagesNotifier, Map<String, List<MessageItemModal>>>(
      MessagesNotifier.new,
    );

class MessagesNotifier extends Notifier<Map<String, List<MessageItemModal>>> {
  @override
  Map<String, List<MessageItemModal>> build() {
    return {};
  }

  void addMessage(String userId, MessageItemModal message) {
    final current = state[userId] ?? [];
    state = {
      ...state,
      userId: [...current, message],
    };
  }
  
  void addMessages(String userId, List<MessageItemModal> messages) {
    state = {
      ...state,
      userId: messages,
    };
  }

  void markMessagesAsRead(String userId) {
    final current = state[userId] ?? [];

    final updated = current.map((message) {
      if (message.status == MessageStatus.read) {
        return message;
      }
      return message.changeStatus(MessageStatus.read);
    }).toList();

    state = {...state, userId: updated};
  }

  void clear() {
    state = {};
  }
}
