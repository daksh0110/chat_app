import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:chat_app/widgets/primary_input.dart';
import 'package:flutter/material.dart';

class ImportAddressScreem extends StatelessWidget {
  const ImportAddressScreem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              onPressed: () => Navigator.of(context).pop(),
              icon: const Icon(Icons.arrow_back_ios),
            ),
            centerTitle: true,
            title: const AppText(
              "Import an Address",
              color: AppColors.textMediumColor,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const AppText(
                    "NAME",
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 4),
                  PrimaryInput(placeholderText: "Contact Name"),
                  const SizedBox(height: 20),
                  const AppText(
                    "ADDRESS",
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 4),
                  PrimaryInput(placeholderText: "Public address (0x) or ENS"),
                  const SizedBox(height: 20),
                  const AppText(
                    "DESCRIPTIONS",
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                  const SizedBox(height: 4),
                  PrimaryInput(placeholderText: "(Optional)"),
                ],
              ),
              const Spacer(),
              const PrimaryButton(text: "Save address"),
            ],
          ),
        ),
      ),
    );
  }
}
