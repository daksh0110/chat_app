import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key, required this.email});
  final String email;

  @override
  State<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  void onVerify() {
    if (_otpController.text.length != 6) return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 64, 32, 16),
          child: Column(
            children: [
              /// CENTER CONTENT
              Expanded(
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const AppText(
                        "Verify your email",
                        color: AppColors.primaryColor,
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                      ),

                      const SizedBox(height: 8),

                      RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            color: AppColors.textSmallColor,
                            fontSize: 12,
                            height: 1.4,
                          ),
                          children: [
                            const TextSpan(
                              text:
                                  "We have sent a 6-digit verification code to your email ",
                            ),
                            TextSpan(
                              text: widget.email,
                              style: const TextStyle(
                                color: AppColors.textMediumColor, // 👈 darker
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const TextSpan(
                              text: ". Please enter it below to continue.",
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 32),

                      TextField(
                        controller: _otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        textAlign: TextAlign.center,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        style: const TextStyle(
                          fontSize: 22,
                          letterSpacing: 14,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textMediumColor,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          filled: true,
                          fillColor: AppColors.inputBoxColor,
                          hintText: "••••••",
                          hintStyle: TextStyle(
                            color: AppColors.placeholderTextColor,
                            letterSpacing: 14,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(6),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {},
                          child: const AppText(
                            "Resend code",
                            color: AppColors.primaryColor,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// BOTTOM BUTTON (NOT CENTERED)
              SizedBox(
                width: double.infinity,
                child: PrimaryButton(text: "Verify", onClick: onVerify),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
