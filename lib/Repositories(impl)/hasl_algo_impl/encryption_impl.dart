import 'package:password/Contracts%20(%20interfaces%20)/encryption_repo.dart';
import 'package:cryptography/cryptography.dart';
import 'package:password/Models/encrypted_password.dart';

class EncryptionImpl implements EncryptionRepo {
  @override
  Future<String> decryptPassword({
    required EncryptedPassword encryptedPassword,
    required String masterPassword,
    required SecretKey key,
  }) {
    throw UnimplementedError();
  }

  @override
  encryptPassword({required SecretKey key, required String websitePassword}) {
    throw UnimplementedError();
  }
}
