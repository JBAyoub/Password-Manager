import 'dart:convert';
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import 'package:password/Contracts%20(%20interfaces%20)/vault_repo.dart';
import 'package:password/Models/vault.dart';

class VaultService {
  Vault? _vault;
  Vault? get vault => _vault;
  VaultRepo vaultRepo;
  VaultService(this.vaultRepo, vr);
  SecretKey get key {
    if (_vault?.key == null) {
      throw Exception("Vault is locked.");
    }

    return _vault!.key!;
  }

  List<int> generateSalt() {
    final random = Random.secure();
    return List<int>.generate(16, (_) => random.nextInt(256));
  }

  Future<void> createVault(String masterPassword) async {
    final salt = generateSalt();

    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );

    final secretKey = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(masterPassword)),
      nonce: salt,
    );

    final algorithm = AesGcm.with256bits();
    final verificationBox = await algorithm.encrypt(
      utf8.encode("PASSWORD_MANAGER_VAULT"),
      secretKey: secretKey,
    );
    final vault = Vault(
      id: 1,
      salt: salt,
      key: secretKey,
      verificationCipherText: verificationBox.cipherText,
      verificationNonce: verificationBox.nonce,
      verificationMac: verificationBox.mac.bytes,
    );
    await vaultRepo.saveVault(vault: vault);
    _vault = vault;
  }

  Future<void> loadVault() async {
    _vault = await vaultRepo.loadVault();
  }

  Future<void> unlockVault(String masterPassword) async {
    if (_vault == null) {
      throw Exception("Vault has not been loaded.");
    }
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );

    final key = await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(masterPassword)),
      nonce: _vault!.salt,
    );
    final algorithm = AesGcm.with256bits();

    final verificationBox = SecretBox(
      _vault!.verificationCipherText,
      nonce: _vault!.verificationNonce,
      mac: Mac(_vault!.verificationMac),
    );

    try {
      final bytes = await algorithm.decrypt(verificationBox, secretKey: key);
      final text = utf8.decode(bytes);

      if (text != "PASSWORD_MANAGER_VAULT") {
        throw Exception("Incorrect master password.");
      }
      _vault!.key = key;
    } on SecretBoxAuthenticationError {
      throw Exception("Incorrect master password.");
    }
  }

  void lockVault() {
    _vault?.key = null;
  }
}
