import 'package:chat_app/services/api_client.dart';
import 'package:chat_app/services/authentication_api_servcie.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:chat_app/widgets/primary_input.dart';
import 'package:flutter/material.dart';

class EmailScreen extends StatefulWidget {
  const EmailScreen({super.key});

  @override
  State<EmailScreen> createState() => _EmailScreenState();
}

class _EmailScreenState extends State<EmailScreen> {
  final TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final authApi = AuthenticationApiServcie(dio: ApiClient.dio);
  bool loading = false;
  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  void onContinue() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      loading = true;
    });

    try {
      final response = await authApi.sendOtp(
        email: emailController.text.trim(),
      );

      if (response.success) {
        await Navigator.pushNamed(
          context,
          "/email-verification",
          arguments: emailController.text.trim(),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: AppText(
              response.data['message'] ?? "an error occured",
              color: AppColors.placeholderTextColor,
            ),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: AppText(
            "Something went wrong. Please try again.",
            color: AppColors.placeholderTextColor,
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 16),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset("assets/images/logo-chatx.png", height: 72),
                    const SizedBox(height: 15),
                    const AppText(
                      "Stay connected with Anonimity",
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),

              Expanded(
                flex: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppText(
                      "EMAIL",
                      color: AppColors.textSmallColor,
                      fontSize: 12,
                    ),
                    const SizedBox(height: 10),

                    Form(
                      key: _formKey,
                      child: PrimaryInput(
                        placeholderText: "Enter your email",
                        controller: emailController,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                            return 'Enter a valid email';
                          }
                          return null;
                        },
                      ),
                    ),

                    const Spacer(),

                    SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                        text: "Continue",
                        onClick: onContinue,
                        loading: loading,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
