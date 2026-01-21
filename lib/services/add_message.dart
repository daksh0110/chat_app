import 'package:chat_app/modal/message_item_modal.dart';
import 'package:chat_app/provider/providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void addMessage(WidgetRef ref, String roomId, MessageItemModal message) {
  final current = ref.read(messagesProvider);

  ref.read(messagesProvider.notifier).state = {
    ...current,
    roomId: [...(current[roomId] ?? []), message],
  };
}
