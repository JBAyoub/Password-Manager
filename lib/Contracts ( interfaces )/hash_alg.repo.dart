import 'package:cryptography/cryptography.dart';
import 'package:password/Models/EncryptionResult.dart';

abstract interface class HashAlgRepo {
  Future<EncryptionResult> encryptPassword({
    required String websitePassword,
    required String masterPassword,
  });
  Future<String> decryptPassword({
    required String masterPassword,
    required List<int> salt,
    required SecretBox secretBox,
  });
}
