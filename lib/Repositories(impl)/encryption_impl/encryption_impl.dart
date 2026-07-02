import 'package:password/Contracts%20(%20interfaces%20)/encryption_repo.dart';
import 'package:cryptography/cryptography.dart';
import 'package:password/Data%20Sources/encryption_script.dart';
import 'package:password/Models/encrypted_password.dart';

class EncryptionImpl implements EncryptionRepo {
  final EncryptionScript encryptionScript;

  EncryptionImpl(this.encryptionScript);

  @override
  Future<EncryptedPassword?> encryptPassword({
    required SecretKey key,
    required String websitePassword,
  }) async {
    return await encryptionScript.encrypt(key, websitePassword);
  }

  @override
  Future<String?> decryptPassword({
    required EncryptedPassword encryptedPassword,
    required String masterPassword,
    required SecretKey key,
  }) async {
    return await encryptionScript.decrypt(key, encryptedPassword);
  }
}
