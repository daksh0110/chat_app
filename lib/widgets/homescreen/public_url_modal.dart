import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class PublicUrlModal extends StatelessWidget {
  const PublicUrlModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,

      children: [
        RichText(
          text: const TextSpan(
            text: "Public URL is ",
            style: TextStyle(
              color: AppColors.textMediumColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            children: [
              TextSpan(
                text: "Enabled",
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  color: AppColors.textMediumColor,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const AppText(
          "You are now enabling public url.It means, you can invite people to message you directly using url below.",
          color: AppColors.secondaryLightColor,
          textAlign: TextAlign.center,
          fontSize: 14,
        ),
        const SizedBox(height: 20),
        Image(
          image: AssetImage("assets/images/qrcode.png"),
          height: 100,
          width: 100,
        ),
        const SizedBox(height: 20),
        const AppText("Your public url:", color: AppColors.secondaryLightColor),
        const AppText(
          "public.cx/0x79BFAA8B226FC527315A8C07B2953927382CDE8B",
          color: AppColors.primaryColor,
          fontSize: 14,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 10),
        const Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.copy, size: 14),
            SizedBox(width: 10),
            AppText(
              "click to copy",
              color: AppColors.secondaryLightColor,
              fontSize: 12,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            PrimaryButton(
              text: "Disable public url",
              backgroundColor: Colors.transparent,
              textColor: Colors.black,
              fullWidth: false,
              borderColor: Colors.black,
            ),
            const SizedBox(width: 10),
            PrimaryButton(text: "Save & Close", fullWidth: false),
          ],
        ),
      ],
    );
  }
}
