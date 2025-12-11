import 'package:chat_app/data/phraseData.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:chat_app/widgets/primary_dropdown.dart';
import 'package:chat_app/widgets/primary_input.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // move entries here (or keep them outside)
    final List<DropdownMenuEntry<String>> entries = [
      DropdownMenuEntry(value: 'male', label: "Male"),
      DropdownMenuEntry(value: 'female', label: "Female"),
    ];
    final String phrase = phrases.map((p) => p.text).join(" ");
    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(32, 64, 32, 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Scrollbar(
                      thumbVisibility: false,
                      trackVisibility: false,
                      thickness: 0,
                      interactive: false,
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.only(bottom: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
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
                                    child: const Icon(
                                      Icons.add,
                                      color: AppColors.secondaryColor,
                                    ),
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
                            ),
                            const SizedBox(height: 20),
                            const AppText(
                              "HOW ARE YOU CALLED",
                              color: AppColors.textSmallColor,
                              textAlign: TextAlign.left,
                              fontSize: 12,
                            ),
                            const SizedBox(height: 10),
                            PrimaryInput(placeholderText: "NickName"),
                            const SizedBox(height: 5),
                            const AppText(
                              "e.g  Azuki, Azuki #99, ... (some symbols are allowed)",
                              color: AppColors.textSmallColor,
                              fontSize: 12,
                            ),
                            const SizedBox(height: 20),
                            const AppText(
                              "GENDER",
                              color: AppColors.textSmallColor,
                              textAlign: TextAlign.left,
                              fontSize: 12,
                            ),
                            const SizedBox(height: 10),
                            PrimaryDropdown(entries: entries),
                            const SizedBox(height: 15),
                            const AppText(
                              "WHAT ARE YOU ON INTERESTED ON",
                              color: AppColors.textSmallColor,
                              textAlign: TextAlign.left,
                              fontSize: 12,
                            ),
                            const SizedBox(height: 10),
                            PrimaryInput(placeholderText: "(optional)"),
                            const SizedBox(height: 5),
                            const AppText(
                              "e.g  Design, Photography, ... etc.",
                              color: AppColors.textSmallColor,
                              fontSize: 12,
                            ),
                            const SizedBox(height: 20),
                            const Row(
                              children: [
                                AppText(
                                  "YOUR KEY PHRASE",
                                  color: AppColors.textSmallColor,
                                  textAlign: TextAlign.left,
                                  fontSize: 12,
                                ),
                                Spacer(),
                                AppText(
                                  "COPY",
                                  color: AppColors.primaryColor,
                                  textAlign: TextAlign.left,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            PrimaryInput(
                              placeholderText: phrase,
                              maxlines: 4,
                              readOnly: true,
                            ),
                            const SizedBox(height: 5),
                            AppText(
                              "Save the key phrase to the safe place, this is the one and only access to your account. ",
                              color: AppColors.dangerColor,
                              textAlign: TextAlign.left,
                              fontWeight: FontWeight.w400,
                              fontSize: 12,
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Transform.translate(
                                  offset: const Offset(-8, -6),
                                  child: Checkbox(
                                    value: false,
                                    onChanged: (value) => true,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),

                                const SizedBox(width: 4),

                                const Expanded(
                                  child: AppText(
                                    "By registering an account, you are agreeing Terms and Agreement of Chatx.",
                                    color: AppColors.textSmallColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    width: double.infinity,
                    child: PrimaryButton(
                      text: "Continue",
                      onCick: () {
                        Navigator.pushNamed(context, '/verify');
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
