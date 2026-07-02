import 'dart:convert';
import 'package:cryptography/cryptography.dart';
import 'package:password/Services/vault_service.dart';

class EncryptionScript {
  final VaultService vs;
  EncryptionScript(this.vs);
  final Cipher algorithm = AesGcm.with256bits();

  Future<SecretBox> encrypt(String password) async {
    return await algorithm.encrypt(utf8.encode(password), secretKey: vs.key);
  }

  Future<String> decrypt(SecretBox box) async {
    if (vs.vault?.key == null) {
      throw Exception("Vault is locked.");
    }
    final bytes = await algorithm.decrypt(box, secretKey: vs.vault!.key!);
    return utf8.decode(bytes);
  }
}
