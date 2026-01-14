import 'package:chat_app/screens/email_screen.dart';
import 'package:chat_app/screens/email_verification.dart';
import 'package:chat_app/screens/homepage_screen.dart';
import 'package:chat_app/screens/onboarding_screen.dart';
import 'package:chat_app/screens/register_screen.dart';
import 'package:chat_app/screens/search_user_screen.dart';
import 'package:chat_app/screens/splash_screen.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/utils/slide_page_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          case '/email':
            return SlidePageRoute(page: EmailScreen());
          case '/email-verification':
            String email = settings.arguments as String;
            return SlidePageRoute(page: EmailVerificationScreen(email: email));
          case '/register':
            String email = settings.arguments as String;
            return SlidePageRoute(page: RegisterScreen(email: email));
          // case '/verify':
          //   String phrase = settings.arguments as String;
          //   return SlidePageRoute(page: VerifyScreen(phrase: phrase));
          // case '/verify-success':
          //   return SlidePageRoute(page: VerifySuccess());
          case '/homepage':
            return SlidePageRoute(page: HomepageScreen());
          case '/search-user':
            return SlidePageRoute(page: SearchUserScreen());
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
