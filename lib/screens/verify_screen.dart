import 'package:chat_app/data/phraseData.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:chat_app/widgets/verify_screen/phrase_container.dart';
import 'package:flutter/material.dart';

class VerifyScreen extends StatelessWidget {
  const VerifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double bottomPadding =
        MediaQuery.of(context).viewInsets.bottom + 16.0;

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(32, 32, 32, 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Column(
                              children: [
                                const AppText(
                                  "Verify Key Phrase",
                                  color: AppColors.textMediumColor,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                                const SizedBox(height: 10),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 64,
                                  ),
                                  child: const AppText(
                                    "Tap the words and put them in the correct order.",
                                    color: AppColors.textSmallColor,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 20),

                          PhraseContainer(),
                        ],
                      ),
                    ),
                  ),
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(32, 8, 32, bottomPadding),
                  child: SafeArea(
                    top: false,
                    child: PrimaryButton(text: "Verify"),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
