import 'package:cryptography/cryptography.dart';
import 'package:password/Models/encrypted_password.dart';

abstract class EncryptionScript {
  static Future<EncryptedPassword?> encrypt(
    SecretKey secretKey,
    String password,
  ) async {
    return null;
  }

  static Future<String?> decrypt(SecretKey secretKey, String password) async {
    return null;
  }
}
