import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/homescreen/public_url_modal.dart';
import 'package:flutter/material.dart';

class PopupModal extends StatelessWidget {
  const PopupModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      backgroundColor: AppColors.inputBoxColor,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 40, 25, 40),
        child: PublicUrlModal(),
      ),
    );
  }
}
