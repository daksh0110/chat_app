import 'package:chat_app/provider/messages/chat_list_provider.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/homescreen/chat_list.dart';
import 'package:chat_app/widgets/homescreen/group_list.dart';
import 'package:chat_app/widgets/homescreen/homepage_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomepageScreen extends ConsumerStatefulWidget {
  const HomepageScreen({super.key});

  @override
  ConsumerState<HomepageScreen> createState() {
    return _HomepageScreenState();
  }
}

class _HomepageScreenState extends ConsumerState<HomepageScreen> {
  final PageController pageViewController = PageController();
  int selectedTab = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pageViewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void openSearchUserScreen() {
      Navigator.of(context).pushNamed('/search-user');
    }

    final chatListItems = ref.watch(chatListProvider);

    return Scaffold(
      floatingActionButton: Transform.translate(
        offset: const Offset(-10, 0),
        child: FloatingActionButton(
          onPressed: openSearchUserScreen,
          backgroundColor: AppColors.textMediumColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: Image.asset("assets/icons/message-icon.png"),
        ),
      ),

      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.backgroundColor,
        title: Transform.translate(
          offset: const Offset(20, 0),
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
            HomepageNavigationBar(
              selectedTab: selectedTab,
              onTabChanged: (index) {
                setState(() {
                  selectedTab = index;
                  pageViewController.animateToPage(
                    index,
                    duration: const Duration(milliseconds: 180),
                    curve: Curves.easeInOut,
                  );
                });
              },
            ),
            Expanded(
              child: PageView(
                controller: pageViewController,

                onPageChanged: (value) {
                  setState(() {
                    selectedTab = value;
                  });
                },
                children: [
                  ChatList(items: chatListItems),
                  GroupList(items: chatListItems),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
