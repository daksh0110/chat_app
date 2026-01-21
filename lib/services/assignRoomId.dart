import 'package:chat_app/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void assignRoomId(WidgetRef ref, String RoomId, String userId) {
  final currentChatList = ref.read(chatListProvider);

  ref.read(chatListProvider.notifier).state = [
    for (final chatItem in currentChatList)
      if (chatItem.id == userId) chatItem.assignRoomId(RoomId) else chatItem,
  ];
}
