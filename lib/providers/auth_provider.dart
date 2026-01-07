import 'package:chat_app/modal/authentication_data.dart';
import 'package:chat_app/modal/enums/auth_state.dart';
import 'package:chat_app/services/api_client.dart';
import 'package:chat_app/services/secure_storage.dart';
import 'package:chat_app/services/user_api_service.dart';
import 'package:flutter_riverpod/legacy.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(AuthState.loading) {
    checkSession();
  }

  final storage = SecureStorage();

  Future<void> checkSession() async {
    final accessToken = await storage.getData(key: 'accessToken');
    final refreshToken = await storage.getData(key: 'refreshToken');
    final deviceId = await storage.getData(key: 'deviceId');

    if (accessToken != null && refreshToken != null && deviceId != null) {
      state = AuthState.hasSession;
    } else {
      state = AuthState.unauthenticated;
    }
  }

  Future<void> verifySession() async {
    final userClient = UserApiService(dio: ApiClient.dio);

    final accessToken = await storage.getData(key: 'accessToken');
    final refreshToken = await storage.getData(key: 'refreshToken');
    final deviceId = await storage.getData(key: 'deviceId');

    if (accessToken == null || refreshToken == null || deviceId == null) {
      state = AuthState.unauthenticated;
      return;
    }

    try {
      final response = await userClient.verifyUser(
        AuthenticationData(
          accessToken: accessToken,
          refreshToken: refreshToken,
          deviceId: deviceId,
        ),
      );

      final data = response.data;
      if (data == null) {
        await storage.clearAll();
        state = AuthState.unauthenticated;
        return;
      }

      await storage.setData(key: "accessToken", name: data.accessToken);
      await storage.setData(key: "refreshToken", name: data.refreshToken);
      await storage.setData(key: "deviceId", name: data.deviceId);

      state = AuthState.authenticated;
    } catch (_) {
      await storage.clearAll();
      state = AuthState.unauthenticated;
    }
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier();
});
