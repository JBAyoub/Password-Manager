import 'package:password/Contracts%20(%20interfaces%20)/hash_alg.repo.dart';
import 'package:cryptography/cryptography.dart';
import 'package:password/Data%20Sources/encryption_script.dart';
import 'package:password/Models/EncryptionResult.dart';

class LocalHashAlg implements HashAlgRepo {
  final pbkdf2 = Pbkdf2(
    macAlgorithm: Hmac.sha256(),
    iterations: 100000,
    bits: 256,
  );
  @override
  Future<EncryptionResult> encryptPassword({
    required String masterPassword,
    required String websitePassword,
  }) async {
    return await EncryptionScript.encrypt(
      masterPassword: masterPassword,
      websitePassword: websitePassword,
      pbkdf2: pbkdf2,
    ); //save encryption;
  }

  @override
  Future<String> decryptPassword({
    required String masterPassword,
    required List<int> salt,
    required SecretBox secretBox,
  }) async {
    return await EncryptionScript.decrypt(
      masterPassword: masterPassword,
      salt: salt,
      secretBox: secretBox,
      pbkdf2: pbkdf2,
    );
  }
}
