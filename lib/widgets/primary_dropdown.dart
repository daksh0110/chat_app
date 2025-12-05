import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryDropdown extends StatelessWidget {
  const PrimaryDropdown({super.key, required this.entries});
  final List<DropdownMenuEntry> entries;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu(
      dropdownMenuEntries: entries,
      width: double.maxFinite,
      hintText: "Unspeciefied",
      trailingIcon: const Icon(
        Icons.arrow_drop_down_rounded,
        color: AppColors.placeholderTextColor,
        size: 30,
      ),

      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 0),

        filled: true,
        hintStyle: TextStyle(color: AppColors.placeholderTextColor),
        fillColor: AppColors.inputBoxColor,
        border: OutlineInputBorder(borderSide: BorderSide.none),
        iconColor: AppColors.placeholderTextColor,
      ),
    );
  }
}
