import 'package:cryptography/cryptography.dart';
import 'package:password/Contracts%20(%20interfaces%20)/vault_repo.dart';
import 'package:password/Models/vault.dart';

class VaultImpl implements VaultRepo {
  @override
  Future<SecretKey> getSecretKey() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveSalt({required List<int> salt}) {
    throw UnimplementedError();
  }

  @override
  Future<void> saveVault({required Vault vault}) {
    throw UnimplementedError();
  }

  @override
  Future<Vault> loadVault() {
    throw UnimplementedError();
  }
}
