import 'dart:convert';

import 'package:cryptography/cryptography.dart';
import 'package:password/Contracts%20(%20interfaces%20)/encryption_repo.dart';
import 'package:password/Services/vault_service.dart';

class EncryptionService {
  final EncryptionRepo encryptionRepo;
  final VaultService vs;
  EncryptionService(this.encryptionRepo, this.vs);
  final Cipher algorithm = AesGcm.with256bits();
  Future<SecretBox> encrypt(String password) async =>
      await algorithm.encrypt(utf8.encode(password), secretKey: vs.key);
  Future<String> decrypt(SecretBox box) async =>
      utf8.decode(await algorithm.decrypt(box, secretKey: vs.key));
}
