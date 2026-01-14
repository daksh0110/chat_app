import 'package:chat_app/modal/chat_search_item.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/circle_bubble.dart';

class SearchListObject extends StatelessWidget {
  const SearchListObject({super.key, required this.item});
  final ChatSearchItem item;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => ChatScreen(
              avatar: item.userMainImageUrl,
              isTyping: false,
              userName: item.name,
              userId: item.id,
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
              child: CircleBubble(imageProvider: item.userMainImageUrl),
            ),
            const SizedBox(width: 10),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    AppText(
                      item.name,
                      color: AppColors.textMediumColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    AppText(item.email, color: AppColors.placeholderTextColor),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
