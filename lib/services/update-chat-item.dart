import 'package:chat_app/modal/chat_litst_item.dart';
import 'package:chat_app/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void updateChatInfo(WidgetRef ref, ChatListItem data) {
  final currentChatList = ref.read(chatListProvider);

  final index = currentChatList.indexWhere((chat) => chat.id == data.id);

  if (index != -1) {
    final updatedChat = currentChatList[index].updateInfo(data);

    ref.read(chatListProvider.notifier).state = [
      updatedChat,
      ...currentChatList.where((c) => c.id != data.id),
    ];
    return;
  }

  ref.read(chatListProvider.notifier).state = [data, ...currentChatList];
}
