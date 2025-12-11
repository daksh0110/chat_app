import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/circle_bubble.dart';
import 'package:chat_app/widgets/primary_button.dart';
import 'package:chat_app/widgets/secondary_button.dart';
import 'package:flutter/material.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.fromLTRB(32, 64, 32, 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(0, 0, 32, 0),
              child: const Text(
                "Start a Fun Communication with Anonymity",

                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primaryColor,
                ),
              ),
            ),

            Expanded(
              child: SizedBox(
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Positioned(
                      left: 120,
                      top: 80,
                      child: CircleBubble(
                        height: 125,
                        image: Image.asset(
                          'assets/images/1.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -10,
                      top: 120,
                      child: CircleBubble(
                        height: 100,
                        image: Image.asset(
                          'assets/images/2.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -40,
                      top: 120,
                      child: CircleBubble(
                        height: 120,
                        image: Image.asset(
                          'assets/images/3.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: -60,
                      top: 225,
                      child: CircleBubble(
                        height: 100,
                        image: Image.asset(
                          'assets/images/4.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 80,
                      top: 215,
                      child: CircleBubble(
                        height: 100,
                        image: Image.asset(
                          'assets/images/5.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 60,
                      top: 210,
                      child: CircleBubble(
                        height: 90,
                        image: Image.asset(
                          'assets/images/6.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    Positioned(
                      right: -40,
                      bottom: 200,

                      child: CircleBubble(
                        height: 100,
                        image: Image.asset(
                          'assets/images/7.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

                    // Another random small bubble (example)
                    Positioned(
                      left: 1,
                      bottom: 100,
                      child: CircleBubble(
                        height: 150,
                        image: Image.asset(
                          'assets/images/8.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      right: 60,
                      bottom: 130,
                      child: CircleBubble(
                        height: 120,
                        image: Image.asset(
                          'assets/images/9.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                PrimaryButton(
                  text: 'Create an Account',
                  onCick: () {
                    Navigator.pushNamed(context, "/register");
                  },
                ),
                SecondaryButton(text: "Restore"),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
