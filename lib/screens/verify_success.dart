import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class VerifySuccess extends StatelessWidget {
  const VerifySuccess({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsetsGeometry.fromLTRB(32, 32, 32, 8),
          child: Column(
            children: [
              // This Expanded centers its child vertically
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryLightColor,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsetsGeometry.all(20),
                          child: const Icon(
                            Icons.check,
                            color: AppColors.primaryColor,
                            size: 60,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      const AppText(
                        "Verify Success!",
                        color: AppColors.textMediumColor,
                        fontWeight: FontWeight.w600,
                        fontSize: 20,
                      ),
                      const SizedBox(height: 10),
                      Padding(
                        padding: EdgeInsetsGeometry.symmetric(horizontal: 32),
                        child: const AppText(
                          "Successfully verified your account, tap the finish button below to open your main Chatx.",
                          color: AppColors.textSmallColor,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w400,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Button stays at the bottom
              const PrimaryButton(text: "Finish"),
            ],
          ),
        ),
      ),
    );
  }
}
