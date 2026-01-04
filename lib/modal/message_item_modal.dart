import 'package:chat_app/modal/enums/message_direction.dart';
import 'package:chat_app/modal/enums/message_status.dart';

class MessageItemModal {
  final String id;
  final String message;
  final MessageDirection messageBy;
  final DateTime messageAt;
  final MessageStatus status;

  const MessageItemModal({
    required this.id,
    required this.message,
    required this.messageBy,
    required this.messageAt,
    required this.status,
  });
}
