import 'package:cryptography/cryptography.dart';
import 'package:password/Contracts%20(%20interfaces%20)/password_repo.dart';
import 'package:password/Models/encrypted_password.dart';
import 'package:password/Services/EncryptionService.dart';
import 'package:password/Services/vault_service.dart';

class PasswordService {
  final VaultService vr;
  final PasswordRepo pr;
  final EncryptionService encryptionService;
  PasswordService({
    required this.vr,
    required this.pr,
    required this.encryptionService,
  });

  Future<void> encryptAndSavePassword(String password, SecretKey key) async {
    final encryptedPassword = await encryptionService.encrypt(
      password: password,
      key: vr.vault!.key!,
    );
    await pr.savePassword(encryptedPassword);
  }

  Future<String> decryptPassword(EncryptedPassword encryptedPassword) async {
    return await encryptionService.decrypt(
      password: encryptedPassword,
      key: vr.vault!.key!,
    );
  }
}
