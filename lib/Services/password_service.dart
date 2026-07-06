import 'package:cryptography/cryptography.dart';
import 'package:password/Contracts%20(%20interfaces%20)/password_repo.dart';
import 'package:password/Models/encrypted_password.dart';
import 'package:password/Services/EncryptionService.dart';
import 'package:password/Services/vault_service.dart';

class PasswordService {
  final VaultService vaultService;
  final PasswordRepo passwordRepo;
  final EncryptionService encryptionService;
  PasswordService({
    required this.vaultService,
    required this.passwordRepo,
    required this.encryptionService,
  });

  Future<EncryptedPassword> encryptAndSavePassword(
    String password,
    SecretKey key,
  ) async {
    if (vaultService.currentKey == null) {
      throw Exception("Vault is not unlocked. Cannot encrypt password.");
    }
    final encryptedPassword = await encryptionService.encrypt(
      password: password,
      key: vaultService.currentKey!,
    );
    await passwordRepo.savePassword(encryptedPassword);
    return encryptedPassword;
  }

  Future<String> decryptPassword(EncryptedPassword encryptedPassword) async {
    return await encryptionService.decrypt(
      password: encryptedPassword,
      key: vaultService.currentKey!,
    );
  }
}
