import 'dart:io';

import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/popUp_modal.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() {
    return _ChatListState();
  }
}

class _ChatListState extends State<ChatList> {
  void showPopup() {
    showDialog(context: context, builder: (context) => PopupModal());
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(image: AssetImage("assets/icons/message-icon-2.png")),
            const SizedBox(height: 10),
            const AppText(
              "No chat found",
              color: AppColors.secondaryLightColor,
            ),
            const AppText(
              "Start a new one?",
              color: AppColors.secondaryLightColor,
            ),
            const SizedBox(height: 60),
            PrimaryButton(
              text: "Enable Public url",
              fullWidth: false,
              onCick: () => {showPopup()},
            ),
            const SizedBox(height: 10),
            const AppText("or", color: AppColors.placeholderTextColor),
            const SizedBox(height: 10),
            GestureDetector(
              child: AppText(
                "import an address",
                color: AppColors.primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
