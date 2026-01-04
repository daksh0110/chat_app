import 'package:chat_app/modal/enums/message_direction.dart';
import 'package:chat_app/modal/message_item_modal.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:flutter/material.dart';

class MessageItem extends StatelessWidget {
  const MessageItem({super.key, required this.message});

  final MessageItemModal message;

  @override
  Widget build(BuildContext context) {
    final bool sendByUser = message.messageBy == MessageDirection.sent;
    return Align(
      alignment: sendByUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: sendByUser
              ? AppColors.secondaryColor
              : AppColors.inputBoxColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(sendByUser ? 8 : 0),
            bottomLeft: Radius.circular(8),
            bottomRight: Radius.circular(8),
            topRight: Radius.circular(!sendByUser ? 8 : 0),
          ),
        ),
        child: AppText(
          message.message,
          color: sendByUser ? Colors.white : AppColors.textMediumColor,
        ),
      ),
    );
  }
}
