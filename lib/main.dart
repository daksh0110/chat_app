import 'package:chat_app/screens/homepage_screen.dart';
import 'package:chat_app/screens/onboarding_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/verify_screen.dart';
import 'package:chat_app/screens/verify_success.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',

      theme: ThemeData(
        fontFamily: 'SpaceGrotesk',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(5, 115, 243, 1),
        ),
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      home: Scaffold(body: HomepageScreen()),
    );
  }
}
