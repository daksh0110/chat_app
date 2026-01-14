import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/modal/chat_litst_item.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/utils/message_time.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/circle_bubble.dart';

class ChatListTile extends StatelessWidget {
  const ChatListTile({super.key, required this.item});
  final ChatListItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => ChatScreen(
              isTyping: false,
              userName: item.name,
              avatar: item.profilePic,
              userId: "1",
              initialRoomId: item.roomId,
            ),
          ),
        );
      },

      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        child: Row(
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: CircleBubble(imageProvider: item.profilePic),
            ),
            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          item.name,
                          color: AppColors.textMediumColor,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),

                      AppText(
                        formatLastMessageTime(item.lastMessageAt),
                        color: AppColors.textMediumColor,
                        fontSize: 12,
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Row(
                    children: [
                      Expanded(
                        child: AppText(
                          item.message,
                          color: AppColors.placeholderTextColor,
                        ),
                      ),

                      if (item.newMessageCount > 0)
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: const BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: AppText(
                            item.newMessageCount.toString(),
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
