import 'package:chat_app/modal/authentication_data.dart';
import 'package:chat_app/services/api_client.dart';
import 'package:chat_app/services/secure_storage.dart';
import 'package:chat_app/services/user_api_service.dart';
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
    Navigator.pushReplacementNamed(context, '/homepage');
  }

  void _goToOnboarding() {
    Navigator.pushReplacementNamed(context, '/onboarding');
  }

  Future<void> _loadData() async {
    final storage = SecureStorage();

    try {
      final accessToken = await storage.getData(key: "accessToken");
      final refreshToken = await storage.getData(key: "refreshToken");
      final deviceId = await storage.getData(key: "deviceId");

      if (refreshToken == null || deviceId == null) {
        await storage.clearAll();
        _goToOnboarding();
        return;
      }

      final userApi = UserApiService(dio: ApiClient.dio);

      final response = await userApi.verifyUser(
        AuthenticationData(
          accessToken: accessToken ?? "",
          refreshToken: refreshToken,
          deviceId: deviceId,
        ),
      );
      if (response.success != true) {
        await storage.clearAll();
        _goToOnboarding();
        return;
      }

      final data = response.data;
      if (data == null) {
        await storage.clearAll();
        _goToOnboarding();
        return;
      }

      await storage.setData(key: "accessToken", name: data.accessToken);
      await storage.setData(key: "refreshToken", name: data.refreshToken);

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
