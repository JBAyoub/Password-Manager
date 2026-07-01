import 'dart:math';
import 'package:password/Contracts%20(%20interfaces%20)/hash_alg.repo.dart';
import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:password/Models/EncryptionResult.dart';

class LocalHashAlg implements HashAlgRepo {
  @override
  Future<EncryptionResult> encryptPassword({
    required String masterPassword,
    required String websitePassword,
  }) async {
    final algorithm = AesGcm.with256bits();
    final random = Random.secure();
    final salt = List<int>.generate(16, (_) => random.nextInt(256));
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );
    final secretKey = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(masterPassword)),
      nonce: salt,
    );
    final secretBox = await algorithm.encrypt(
      utf8.encode(websitePassword),
      secretKey: secretKey,
    );
    return EncryptionResult(secretBox: secretBox, salt: salt);
  }

  @override
  Future<String> decryptPassword({
    required String masterPassword,
    required List<int> salt,
    required SecretBox secretBox,
  }) async {
    final algorithm = AesGcm.with256bits();

    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );

    final secretKey = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(masterPassword)),
      nonce: salt,
    );
    final bytes = await algorithm.decrypt(secretBox, secretKey: secretKey);

    return utf8.decode(bytes);
  }
}
