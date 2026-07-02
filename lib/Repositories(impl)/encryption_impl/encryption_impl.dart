import 'package:password/Contracts%20(%20interfaces%20)/encryption_repo.dart';
import 'package:cryptography/cryptography.dart';
import 'package:password/Services/EncryptionService.dart';

class EncryptionImpl implements EncryptionRepo {
  final EncryptionService encryptionService;

  EncryptionImpl(this.encryptionService);

  @override
  Future<SecretBox?> encryptPassword({required String websitePassword}) async {
    return await encryptionService.encrypt(websitePassword);
  }

  @override
  Future<String?> decryptPassword({required SecretBox box}) async {
    return await encryptionService.decrypt(box);
  }
}
