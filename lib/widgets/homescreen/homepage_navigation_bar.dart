import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/homescreen/navigation_tab.dart';
import 'package:flutter/material.dart';

class HomepageNavigationBar extends StatelessWidget {
  const HomepageNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onTabChanged,
  });

  final int selectedIndex;
  final Function(int) onTabChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.navigationbarColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        children: [
          Expanded(
            child: NavigationTab(
              text: "Messages",
              active: selectedIndex == 0,
              onTap: () => onTabChanged(0),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: NavigationTab(
              text: "Groups",
              active: selectedIndex == 1,
              onTap: () => onTabChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}
