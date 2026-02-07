enum MessageDirection { sent, received }

enum MessageStatus { sending, sent, delivered, read, failed }

class MessageItemModal {
  final String id;
  final String message;
  final MessageDirection messageBy;
  final DateTime messageAt;
  final MessageStatus status;
  final String userId;

  const MessageItemModal({
    required this.id,
    required this.message,
    required this.messageBy,
    required this.messageAt,
    required this.status,
    required this.userId,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'messageBy': messageBy.index,
      'messageAt': messageAt.millisecondsSinceEpoch,
      'status': status.index,
      'userId': userId,
    };
  }

  factory MessageItemModal.fromJson(Map<String, dynamic> map) {
    return MessageItemModal(
      id: map['id'] as String,
      message: map['message'] as String,
      messageBy: MessageDirection.values[map['messageBy'] as int],
      messageAt: DateTime.fromMillisecondsSinceEpoch(map['messageAt'] as int),
      status: MessageStatus.values[map['status'] as int],
      userId: map['userId'] as String,
    );
  }

  MessageItemModal changeStatus(MessageStatus status) {
    return MessageItemModal(
      id: id,
      message: message,
      messageBy: messageBy,
      messageAt: messageAt,
      status: status,
      userId: userId,
    );
  }
}
