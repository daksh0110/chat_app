import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:flutter/material.dart';

class NavigationTab extends StatelessWidget {
  const NavigationTab({
    super.key,
    required this.text,
    this.active = false,
    required this.onTap,
  });
  final String text;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    Color color = active ? Colors.white : AppColors.textMediumColor;
    Color backgroundColor = active
        ? AppColors.textMediumColor
        : Colors.transparent;
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        padding: EdgeInsets.all(20),
        child: AppText(
          text,
          color: color,
          fontSize: 16,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
