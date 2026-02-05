import 'package:chat_app/modal/authentication_data.dart';
import 'package:chat_app/services/api_client.dart';
import 'package:chat_app/services/secure_storage.dart';
import 'package:chat_app/services/user_api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

enum AuthenticatedState { started, authenticated, unauthenticated }

final secureStorageProvider = Provider<SecureStorage>((ref) {
  return SecureStorage();
});

final userApiProvider = Provider<UserApiService>((ref) {
  return UserApiService(dio: ApiClient.dio);
});

final authStateProvider = StateProvider<AuthenticatedState>((ref) {
  return AuthenticatedState.started;
});

final verifySessionProvider = FutureProvider<AuthenticatedState>((ref) async {
  final storage = ref.read(secureStorageProvider);
  final userApi = ref.read(userApiProvider);

  try {
    final accessToken = await storage.getData(key: 'accessToken');
    final refreshToken = await storage.getData(key: 'refreshToken');
    final deviceId = await storage.getData(key: 'deviceId');
    if (accessToken == null || refreshToken == null || deviceId == null) {
      return AuthenticatedState.unauthenticated;
    }

    final response = await userApi.verifyUser(
      AuthenticationData(
        accessToken: accessToken,
        refreshToken: refreshToken,
        deviceId: deviceId,
      ),
    );

    if (response.success) {
      final newAccessToken = response.data?.accessToken;

      if (newAccessToken != null) {
        await storage.setData(key: 'accessToken', name: newAccessToken);
      }
      return AuthenticatedState.authenticated;
    }

    return AuthenticatedState.unauthenticated;
  } catch (_) {
    return AuthenticatedState.unauthenticated;
  }
});
