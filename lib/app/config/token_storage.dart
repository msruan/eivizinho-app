import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenStorage {
  static final storage = FlutterSecureStorage();

  static Future<void> storeToken(String token) async {
    await storage.write(key: 'jwt_token', value: token);
  }

  static Future<String?> getToken() async {
    return await storage.read(key: 'jwt_token');
  }
}
