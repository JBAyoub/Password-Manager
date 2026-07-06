import 'package:password/Contracts%20(%20interfaces%20)/cred_repo.dart';
import 'package:password/Contracts%20(%20interfaces%20)/vault_repo.dart';
import 'package:password/Models/Creds.dart';
import 'package:password/Services/EncryptionService.dart';
import 'package:password/Services/vault_service.dart';

class CredsService {
  final VaultService vaultService;
  final CredRepo _credRepo;
  final EncryptionService encryptionService = EncryptionService();
  CredsService(this.vaultService, this._credRepo);

  Future<void> addCred(Creds c) async {
    await _credRepo.addCred(c);
  }

  Future<void> displayAll() async {
    final listOfCreds = await _credRepo.displayAll();
    if (listOfCreds != null && listOfCreds.isNotEmpty) {
      for (var cred in listOfCreds) {
        print(
          'Website: ${cred.website}, Username: ${cred.username}'
          ',Password: ${await encryptionService.decrypt(password: cred.p, key: vaultService.currentKey!)}',
        );
      }
    } else {
      print('No credentials found.');
    }
  }
}
