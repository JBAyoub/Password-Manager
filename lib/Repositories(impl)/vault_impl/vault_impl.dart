import 'package:cryptography/cryptography.dart';
import 'package:password/Contracts%20(%20interfaces%20)/vault_repo.dart';

class VaultImpl implements VaultRepo {
  @override
  Future<List<int>> generateSalt() {
    throw UnimplementedError();
  }

  @override
  Future<SecretKey> getSecretKey() {
    throw UnimplementedError();
  }

  @override
  Future<bool> lockVault() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveSalt(List<int> salt) {
    throw UnimplementedError();
  }

  @override
  Future<bool> unlockVault(String masterpassword) {
    throw UnimplementedError();
  }
}
