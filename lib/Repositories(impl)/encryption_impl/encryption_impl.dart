import 'package:password/Contracts%20(%20interfaces%20)/encryption_repo.dart';
import 'package:cryptography/cryptography.dart';
import 'package:password/Data%20Sources/encryption_script.dart';

class EncryptionImpl implements EncryptionRepo {
  final EncryptionScript encryptionScript;

  EncryptionImpl(this.encryptionScript);

  @override
  Future<SecretBox?> encryptPassword({required String websitePassword}) async {
    return await encryptionScript.encrypt(websitePassword);
  }

  @override
  Future<String?> decryptPassword({required SecretBox box}) async {
    return await encryptionScript.decrypt(box);
  }
}
