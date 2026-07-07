import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:password/Models/encrypted_password.dart';
import 'package:uuid/uuid.dart';

class EncryptionService {
  final Cipher _algorithm = AesGcm.with256bits();
  var uuid = Uuid();
  Future<EncryptedPassword> encrypt({
    required String password,
    required SecretKey key,
  }) async {
    final secretBox = await _algorithm.encrypt(
      utf8.encode(password),
      secretKey: key,
    );
    return EncryptedPassword(
      // Generate a unique ID for the encrypted password,
      cipherText: secretBox.cipherText,
      nonce: secretBox.nonce,
      mac: secretBox.mac.bytes,
    );
  }

  Future<String> decrypt({
    required EncryptedPassword password,
    required SecretKey key,
  }) async {
    final secretBox = SecretBox(
      password.cipherText,
      nonce: password.nonce,
      mac: Mac(password.mac),
    );
    final bytes = await _algorithm.decrypt(secretBox, secretKey: key);
    return utf8.decode(bytes);
  }
}
