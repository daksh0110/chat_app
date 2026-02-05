import 'dart:async';

import 'package:chat_app/provider/providers.dart';
import 'package:chat_app/services/api_client.dart';
import 'package:chat_app/services/authentication_api_servcie.dart';
import 'package:chat_app/services/secure_storage.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmailVerificationScreen extends ConsumerStatefulWidget {
  const EmailVerificationScreen({super.key, required this.email});

  final String email;

  @override
  ConsumerState<EmailVerificationScreen> createState() =>
      _EmailVerificationScreenState();
}

class _EmailVerificationScreenState
    extends ConsumerState<EmailVerificationScreen> {
  final TextEditingController _otpController = TextEditingController();
  final authApi = AuthenticationApiServcie(dio: ApiClient.dio);
  final secureStorage = SecureStorage();
  bool canResend = false;

  Timer? _timer;
  int _remainingSeconds = 30;
  bool loading = false;

  @override
  void dispose() {
    _otpController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    canResend = false;
    _remainingSeconds = 30;

    const oneSecond = Duration(seconds: 1);
    _timer = Timer.periodic(oneSecond, (Timer timer) {
      if (_remainingSeconds <= 1) {
        timer.cancel();
        setState(() {
          _remainingSeconds = 0;
          canResend = true;
        });
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  void resendOtp() async {
    if (!canResend) return;

    setState(() {
      canResend = false;
      _remainingSeconds = 30;
    });

    final response = await authApi.sendOtp(email: widget.email);

    if (response.success) {
      const oneSecond = Duration(seconds: 1);

      _timer?.cancel();
      _timer = Timer.periodic(oneSecond, (Timer timer) {
        if (_remainingSeconds <= 1) {
          timer.cancel();
          setState(() {
            _remainingSeconds = 0;
            canResend = true;
          });
        } else {
          setState(() {
            _remainingSeconds--;
          });
        }
      });
    } else {
      setState(() {
        canResend = true;
      });

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.message)));
    }
  }

  void onVerify() async {
    if (_otpController.text.length != 6) return;

    setState(() {
      loading = true;
    });

    final response = await authApi.verifyOtp(
      email: widget.email,
      otp: _otpController.text,
    );

    setState(() {
      loading = false;
    });

    if (response.success == true) {
      final data = response.data;

      if (data != null && data.userExist == true) {
        secureStorage.setData(key: "accessToken", name: data.accessToken ?? '');
        secureStorage.setData(key: "deviceId", name: data.deviceId ?? '');
        secureStorage.setData(
          key: 'refreshToken',
          name: data.refreshToken ?? '',
        );
        ref.read(authStateProvider.notifier).state =
            AuthenticatedState.authenticated;
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/homepage",
          (route) => false,
        );
      } else {
        Navigator.pushNamedAndRemoveUntil(
          context,
          "/register",
          (route) => false,
          arguments: widget.email,
        );
      }
    }
    // ❌ ERROR CASE
    else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(response.message)));
    }
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
                          onPressed: canResend
                              ? resendOtp
                              : null, // 👈 THIS disables it
                          child: AppText(
                            canResend
                                ? "Resend code"
                                : "Resend code in $_remainingSeconds",
                            color: canResend
                                ? AppColors.primaryColor
                                : AppColors.placeholderTextColor,
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
                child: PrimaryButton(
                  text: "Verify",
                  onClick: onVerify,
                  loading: loading,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
