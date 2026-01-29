enum MessageDirection { sent, received }

enum MessageStatus { sending, sent, delivered, read, failed }

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

  MessageItemModal changeStatus(MessageStatus status) {
    return MessageItemModal(
      id: id,
      message: message,
      messageBy: messageBy,
      messageAt: messageAt,
      status: status,
    );
  }
}
