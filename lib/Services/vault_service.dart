import 'dart:convert';
import 'dart:math';
import 'package:cryptography/cryptography.dart';
import 'package:password/Contracts%20(%20interfaces%20)/vault_repo.dart';
import 'package:password/Models/vault.dart';
import 'package:password/Services/EncryptionService.dart';

class VaultService {
  Vault? _vault;
  Vault? get vault => _vault;
  VaultRepo vaultRepo;
  EncryptionService encryptionService = EncryptionService();
  VaultService(this.vaultRepo);
  SecretKey? _currentKey;
  SecretKey? get currentKey => _currentKey;

  List<int> generateSalt() {
    final random = Random.secure();
    return List<int>.generate(16, (_) => random.nextInt(256));
  }

  Future<SecretKey> _deriveKey({
    required String masterPassword,
    required List<int> salt,
  }) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha256(),
      iterations: 100000,
      bits: 256,
    );

    return await pbkdf2.deriveKey(
      secretKey: SecretKey(utf8.encode(masterPassword)),
      nonce: salt,
    );
  }

  Future<void> createVault(String masterPassword) async {
    final salt = generateSalt();
    final key = await _deriveKey(masterPassword: masterPassword, salt: salt);
    final verification = await encryptionService.encrypt(
      password: "YOU_REALLY_SHOULD_CHOOSE_A_STRONGER_VERIFICATION_TEXT",
      key: key,
    );

    final vault = Vault(
      id: 1,
      salt: salt,
      verificationCipherText: verification.cipherText,
      verificationNonce: verification.nonce,
      verificationMac: verification.mac,
    );
    await vaultRepo.saveVault(vault: vault);
    _vault = vault;
    _currentKey = key;
  }

  Future<void> loadVault(String masterPassword) async {
    _vault = await vaultRepo.loadVault();
    _currentKey = await _deriveKey(
      masterPassword: masterPassword,
      salt: _vault!.salt,
    );
  }

  Future<void> unlockVault(String masterPassword) async {
    if (_vault == null) {
      await loadVault(masterPassword);
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

      if (text != "YOU_REALLY_SHOULD_CHOOSE_A_STRONGER_VERIFICATION_TEXT") {
        throw Exception("Incorrect master password.");
      }
      _currentKey = key;
    } on SecretBoxAuthenticationError catch (e) {
      throw Exception("Incorrect master password. ${e.message}");
    }
  }

  void lockVault() {
    _currentKey = null;
  }
}
