import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/chat_screen/chat_input_bar.dart';
import 'package:chat_app/widgets/circle_bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatelessWidget {
  final String userName;
  final bool isTyping;
  final ImageProvider avatar;

  const ChatScreen({
    super.key,
    this.userName = 'John Doe',
    this.isTyping = true,
    this.avatar = const AssetImage("assets/images/1.png"),
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        shape: Border(
          bottom: BorderSide(
            color: AppColors.placeholderTextColor.withValues(alpha: 0.2),
            width: 0.5,
          ),
        ),
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        titleSpacing: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(20),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(),
          ),
        ),

        title: Row(
          children: [
            SizedBox(
              height: 48,
              width: 48,
              child: CircleBubble(imageProvider: avatar),
            ),
            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    userName,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textMediumColor,
                  ),

                  const SizedBox(height: 2),
                  AppText(
                    isTyping ? 'typing...' : 'online',
                    color: AppColors.placeholderTextColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),

        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            children: [
              AppText("text", color: AppColors.dangerColor),
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: ChatInputBar(
                  onSend: (text) {
                    // send message
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
