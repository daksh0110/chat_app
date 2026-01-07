import 'package:chat_app/modal/enums/auth_state.dart';
import 'package:chat_app/providers/auth_provider.dart';
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

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Chat App',
      theme: ThemeData(
        fontFamily: 'SpaceGrotesk',
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(5, 115, 243, 1),
        ),
        scaffoldBackgroundColor: AppColors.backgroundColor,
      ),
      home: _buildHome(authState),
      onGenerateRoute: _onGenerateRoute,
    );
  }

  Widget _buildHome(AuthState authState) {
    switch (authState) {
      case AuthState.loading:
        return SplashScreen();

      case AuthState.hasSession:
      case AuthState.authenticated:
        return const HomepageScreen();

      case AuthState.unauthenticated:
        return const OnboardingScreen();
    }
  }

  Route<dynamic>? _onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/onboarding':
        return SlidePageRoute(page: OnboardingScreen());

      case '/email':
        return SlidePageRoute(page: EmailScreen());

      case '/email-verification':
        final email = settings.arguments as String;
        return SlidePageRoute(page: EmailVerificationScreen(email: email));

      case '/register':
        final email = settings.arguments as String;
        return SlidePageRoute(page: RegisterScreen(email: email));

      case '/homepage':
        return SlidePageRoute(page: HomepageScreen());

      case '/search-user':
        return SlidePageRoute(page: SearchUserScreen());

      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('No route defined'))),
        );
    }
  }
}
