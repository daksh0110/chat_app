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
    _loadData();
  }

  Future<void> _loadData() async {
    final storage = SecureStorage();
    final token = await storage.getData(key: "accessToken");
    if (token != null && token.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/homepage');
    } else {
      Navigator.pushReplacementNamed(context, '/onboarding');
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
