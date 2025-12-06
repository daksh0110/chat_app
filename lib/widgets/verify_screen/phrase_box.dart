import 'package:chat_app/modal/phrase.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:flutter/material.dart';

class PhraseBox extends StatelessWidget {
  const PhraseBox({
    super.key,
    required this.phrase,
    this.showNumber = false,
    this.index = "0",
    this.onTap,
  });

  final Phrase phrase;
  final bool showNumber;
  final String? index;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border.all(color: AppColors.secondaryColor),
          borderRadius: BorderRadius.circular(6),
        ),
        child: AppText(
          showNumber ? '$index. ${phrase.text}' : phrase.text,
          color: AppColors.secondaryColor,
          fontSize: 14,
        ),
      ),
    );
  }
}
