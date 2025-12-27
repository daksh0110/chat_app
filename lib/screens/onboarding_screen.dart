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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(32, 32, 32, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.only(right: 32),
                child: Text(
                  "Start a Fun Communication with Anonymity",
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryColor,
                  ),
                ),
              ),

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final w = constraints.maxWidth;
                    final h = constraints.maxHeight;

                    double bubble(double size) => (w * size).clamp(70.0, 160.0);

                    return Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Positioned(
                          left: w * 0.35,
                          top: h * 0.15,
                          child: CircleBubble(
                            height: bubble(0.30),
                            image: Image.asset(
                              'assets/images/1.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: w * -0.05,
                          top: h * 0.22,
                          child: CircleBubble(
                            height: bubble(0.24),
                            image: Image.asset(
                              'assets/images/2.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: w * -0.10,
                          top: h * 0.22,
                          child: CircleBubble(
                            height: bubble(0.26),
                            image: Image.asset(
                              'assets/images/3.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: w * -0.15,
                          top: h * 0.40,
                          child: CircleBubble(
                            height: bubble(0.24),
                            image: Image.asset(
                              'assets/images/4.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: w * 0.20,
                          top: h * 0.38,
                          child: CircleBubble(
                            height: bubble(0.24),
                            image: Image.asset(
                              'assets/images/5.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: w * 0.25,
                          top: h * 0.37,
                          child: CircleBubble(
                            height: bubble(0.22),
                            image: Image.asset(
                              'assets/images/6.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: w * -0.10,
                          bottom: h * 0.45,
                          child: CircleBubble(
                            height: bubble(0.24),
                            image: Image.asset(
                              'assets/images/7.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          left: w * 0.00,
                          bottom: h * 0.25,
                          child: CircleBubble(
                            height: bubble(0.32),
                            image: Image.asset(
                              'assets/images/8.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          right: w * 0.15,
                          bottom: h * 0.30,
                          child: CircleBubble(
                            height: bubble(0.26),
                            image: Image.asset(
                              'assets/images/9.png',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              Column(
                children: [
                  PrimaryButton(
                    text: 'Create an Account',
                    onClick: () {
                      Navigator.pushNamed(context, "/email");
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
