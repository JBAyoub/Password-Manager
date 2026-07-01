import 'dart:convert';
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import 'package:password/Models/EncryptionResult.dart';

abstract class EncryptionScript {
  static Future<EncryptionResult> encrypt({
    required String masterPassword,
    required String websitePassword,
    required Pbkdf2 pbkdf2,
  }) async {
    final algorithm = AesGcm.with256bits();
    final random = Random.secure();
    final salt = List<int>.generate(16, (_) => random.nextInt(256));
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

  static Future<String> decrypt({
    required String masterPassword,
    required List<int> salt,
    required SecretBox secretBox,
    required Pbkdf2 pbkdf2,
  }) async {
    final algorithm = AesGcm.with256bits();
    final secretKey = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(masterPassword)),
      nonce: salt,
    );
    final bytes = await algorithm.decrypt(secretBox, secretKey: secretKey);

    return utf8.decode(bytes);
  }
}
