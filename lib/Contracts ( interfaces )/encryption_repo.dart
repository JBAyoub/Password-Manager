import 'package:cryptography/cryptography.dart';
import 'package:password/Models/encrypted_password.dart';

abstract interface class EncryptionRepo {
  Future<EncryptedPassword?> encryptPassword({
    required SecretKey key,
    required String websitePassword,
  });
  Future<String?> decryptPassword({
    required EncryptedPassword encryptedPassword,
    required String masterPassword,
    required SecretKey key,
  });
}
