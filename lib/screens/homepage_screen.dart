import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/homescreen/chat_list.dart';
import 'package:chat_app/widgets/homescreen/homepage_navigation_bar.dart';
import 'package:flutter/material.dart';

class HomepageScreen extends StatelessWidget {
  const HomepageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Transform.translate(
        offset: const Offset(-10, 0),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.textMediumColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.asset("assets/icons/message-icon.png"),
        ),
      ),

      appBar: AppBar(
        backgroundColor: AppColors.backgroundColor,
        title: Transform.translate(
          offset: const Offset(10, 0),
          child: const AppText(
            "Chatx",
            color: AppColors.textMediumColor,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),

        actions: [
          Padding(
            padding: EdgeInsetsGeometry.symmetric(horizontal: 32),
            child: Row(
              children: [
                const Icon(Icons.search_sharp, size: 25),
                const SizedBox(width: 10),
                const Icon(Icons.settings_outlined, size: 25),
              ],
            ),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.symmetric(horizontal: 32),
        child: Column(
          children: [
            const SizedBox(height: 20),
            HomepageNavigationBar(),
            ChatList(),
          ],
        ),
      ),
    );
  }
}
