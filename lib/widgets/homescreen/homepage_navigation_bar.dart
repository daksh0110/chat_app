import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/homescreen/navigation_tab.dart';
import 'package:flutter/material.dart';

class HomepageNavigationBar extends StatefulWidget {
  const HomepageNavigationBar({super.key});

  @override
  State<HomepageNavigationBar> createState() {
    return _homepageNavigationBarState();
  }
}

class _homepageNavigationBarState extends State<HomepageNavigationBar> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.navigationbarColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: NavigationTab(
              text: "Messages",
              active: selectedIndex == 0,
              onTap: () {
                setState(() => selectedIndex = 0);
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: NavigationTab(
              text: "Groups",
              active: selectedIndex == 1,
              onTap: () {
                setState(() => selectedIndex = 1);
              },
            ),
          ),
        ],
      ),
    );
  }
}
