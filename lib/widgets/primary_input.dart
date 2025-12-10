import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryInput extends StatelessWidget {
  const PrimaryInput({
    super.key,
    required this.placeholderText,
    this.maxlines = 1,
  });
  final String placeholderText;
  final int maxlines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxlines,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.inputBoxColor,
        hintText: placeholderText,
        hintStyle: TextStyle(color: AppColors.placeholderTextColor),
        contentPadding: EdgeInsets.fromLTRB(8, 8, 8, 8),

        border: OutlineInputBorder(borderSide: BorderSide.none),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
