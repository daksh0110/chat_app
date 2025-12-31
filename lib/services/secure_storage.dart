import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final storage = const FlutterSecureStorage();

  Future setData({required String key, required String name}) async {
    await storage.write(key: key, value: name);
  }

  Future getData({required String key}) async {
    final response = await storage.read(key: key);
    return response;
  }

  Future clearAll() async {
    await storage.deleteAll();
  }
}
