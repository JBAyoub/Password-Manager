import 'package:password/Contracts%20(%20interfaces%20)/cred_repo.dart';
import 'package:password/Models/Creds.dart';
import 'package:password/Services/EncryptionService.dart';
import 'package:password/Services/vault_service.dart';

class CredsService {
  final VaultService vaultService;
  final CredRepo _credRepo;
  final EncryptionService _encryptionService;
  CredsService(this.vaultService, this._credRepo, this._encryptionService);

  Future<void> addCred(Creds c) async {
    await _credRepo.addCred(c);
  }

  Future<void> searchByUsername({required String username}) async {
    final List<Creds>? listOfCreds = await _credRepo.searchByUsername(
      username: username,
    );
    await displayListSearch(listOfCreds);
  }

  Future<Creds?> searchById(int id) async {
    return await _credRepo.searchById(id: id);
  }

  Future<void> deleteCred({required int id}) async {
    await _credRepo.delete(id: id);
  }

  Future<void> searchByWebsite({required String website}) async {
    final List<Creds>? listOfCreds = await _credRepo.searchByWebsite(
      website: website,
    );
    await displayListSearch(listOfCreds);
  }

  Future<void> displayAll() async {
    final listOfCreds = await _credRepo.displayAll();
    await displayListSearch(listOfCreds);
  }

  Future<void> displayListSearch(List<Creds>? listOfCreds) async {
    if (listOfCreds != null && listOfCreds.isNotEmpty) {
      for (var cred in listOfCreds) {
        print("---------------------------------");
        print(
          'ID:${cred.id} | Website: ${cred.website} | Username: ${cred.username}'
          ' | Password: ${await _encryptionService.decrypt(password: cred.p, key: vaultService.currentKey!)}',
        );
        print("---------------------------------");
      }
    } else {
      print('No credentials found.');
    }
  }
}
