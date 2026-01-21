import 'package:chat_app/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void resetUnreadCount(WidgetRef ref, String roomId) {
  final chats = ref.read(chatListProvider);

  ref.read(chatListProvider.notifier).state = [
    for (final chat in chats)
      if (chat.roomId == roomId) chat.resetCount() else chat,
  ];
}
