import 'package:chat_app/screens/homepage_screen.dart';
import 'package:chat_app/screens/onboarding_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/screens/verify_screen.dart';
import 'package:chat_app/screens/verify_success.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/utils/slide_page_route.dart';
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
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
        fontFamily: 'SpaceGrotesk',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color.fromRGBO(5, 115, 243, 1),
        ),
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      home: SplashScreen(),

      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/onboarding':
            return SlidePageRoute(page: OnboardingScreen());
          case '/register':
            return SlidePageRoute(page: RegisterScreen());
          case '/verify':
            String phrase = settings.arguments as String;
            return SlidePageRoute(page: VerifyScreen(phrase: phrase));
          case '/verify-success':
            return SlidePageRoute(page: VerifySuccess());
          case '/homepage':
            return SlidePageRoute(page: HomepageScreen());
          default:
            return MaterialPageRoute(
              builder: (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
            );
        }
      },
    );
  }
}
