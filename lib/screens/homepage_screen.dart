import 'package:chat_app/modal/chat_litst_item.dart';
import 'package:chat_app/modal/enums/auth_state.dart';
import 'package:chat_app/providers/auth_provider.dart';
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
  int selectedIndex = 0;
  List<ChatListItem> chatListItems = [];
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: 0);
    Future.microtask(() {
      ref.read(authProvider.notifier).verifySession();
    });
  }

  void openSearchUserScreen() {
    Navigator.of(context).pushNamed('/search-user');
  }

  void onTabChanged(int index) {
    setState(() {
      selectedIndex = index;
      _pageController.animateToPage(
        index,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    if (authState == AuthState.unauthenticated) {
      Future.microtask(() {
        Navigator.of(
          context,
        ).pushNamedAndRemoveUntil('/onboarding', (_) => false);
      });
    }

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
              selectedIndex: selectedIndex,
              onTabChanged: onTabChanged,
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() => selectedIndex = index);
                },
                children: const [
                  ChatList(items: []),
                  GroupList(items: []),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
