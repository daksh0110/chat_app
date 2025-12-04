import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(32, 64, 32, 32),
        child: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const AppText(
                  "Create a new Account",
                  color: AppColors.textMediumColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
                const SizedBox(height: 30),
                DottedBorder(
                  options: RectDottedBorderOptions(
                    dashPattern: [5, 5],
                    borderPadding: EdgeInsets.all(64),
                    padding: EdgeInsets.all(16),
                    color: AppColors.secondaryColor,
                  ),
                  child: const Icon(Icons.add, color: AppColors.secondaryColor),
                ),
                const SizedBox(height: 20),
                const AppText(
                  "Upload a Picture",
                  color: AppColors.textMediumColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
                const SizedBox(height: 2),
                const AppText(
                  "(Automatically created as an NFT asset)",
                  color: AppColors.textSmallColor,
                  fontSize: 12,
                ),
              ],
            ),
            const Spacer(),
            PrimaryButton(text: "Continue"),
          ],
        ),
      ),
    );
  }
}
