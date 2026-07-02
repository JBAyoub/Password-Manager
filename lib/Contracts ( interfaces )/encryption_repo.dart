import 'package:cryptography/cryptography.dart';

abstract interface class EncryptionRepo {
  Future<SecretBox?> encryptPassword({required String websitePassword});
  Future<String?> decryptPassword({required SecretBox box});
}
