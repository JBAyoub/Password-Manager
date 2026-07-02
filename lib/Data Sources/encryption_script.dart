import 'package:cryptography/cryptography.dart';
import 'package:password/Models/encrypted_password.dart';

class EncryptionScript {
  Future<EncryptedPassword?> encrypt(
    SecretKey secretKey,
    String password,
  ) async {
    return null;
  }

  Future<String?> decrypt(
    SecretKey secretKey,
    EncryptedPassword password,
  ) async {
    return null;
  }
}
