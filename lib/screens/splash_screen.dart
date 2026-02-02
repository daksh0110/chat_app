import 'package:chat_app/services/secure_storage.dart';
import 'package:chat_app/theme/app_colors.dart';
import 'package:chat_app/widgets/app_text.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  void _goToHome() {
    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/homepage');
  }

  void _goToOnboarding() {
    if (!mounted) return;

    Navigator.pushReplacementNamed(context, '/onboarding');
  }

  Future<void> _loadData() async {
    final storage = SecureStorage();

    try {
      final accessToken = await storage.getData(key: "accessToken");
      final refreshToken = await storage.getData(key: "refreshToken");
      final deviceId = await storage.getData(key: "deviceId");

      if (accessToken == null || refreshToken == null || deviceId == null) {
        await storage.clearAll();
        _goToOnboarding();
        return;
      }

      _goToHome();
    } catch (e) {
      await storage.clearAll();
      _goToOnboarding();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/logo-chatx.png"),
            SizedBox(height: 15),
            const AppText(
              "Stay connected with Anonimity",
              color: AppColors.primaryColor,
              fontSize: 16,
              fontWeight: FontWeight.w400,
            ),
          ],
        ),
      ),
    );
  }
}
