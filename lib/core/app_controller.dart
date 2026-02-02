import 'package:chat_app/core/navigation/navigator_key.dart';
import 'package:chat_app/provider/app_update_provider.dart';
import 'package:chat_app/provider/providers.dart';
import 'package:chat_app/provider/socket_providers.dart';
import 'package:chat_app/services/Api_calls/app_api_service.dart';
import 'package:chat_app/services/api_client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';

final appControllerProvider = Provider<void>((ref) {
  ref.listen<AsyncValue<AuthenticatedState>>(verifySessionProvider, (_, next) {
    next.whenData((state) {
      ref.read(authStateProvider.notifier).state = state;
    });
  });

  ref.listen<AuthenticatedState>(authStateProvider, (_, next) async {
    final socket = ref.read(socketStateProvider.notifier);
    final appApi = AppApiService(dio: ApiClient.dio);
    final packageInfo = await PackageInfo.fromPlatform();

    final version = packageInfo.version;
    final build = packageInfo.buildNumber;
    final response = await appApi.checkUpdatedversion("$version+$build");

    if (response.data?.isUpdateAvailable == true) {
      ref
          .read(updateControllerProvider.notifier)
          .requireUpdate(
            apkUrl: response.data!.apkUrl!,
            version: response.data!.version!,
          );
      return;
    }
    if (next == AuthenticatedState.authenticated) {
      final token = await ref
          .read(secureStorageProvider)
          .getData(key: 'accessToken');

      if (token != null) {
        await socket.connect(token);
      }

      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/homepage',
        (_) => false,
      );
    } else {
      socket.disconnect();
      navigatorKey.currentState?.pushNamedAndRemoveUntil(
        '/onboarding',
        (_) => false,
      );
    }
  });
});
