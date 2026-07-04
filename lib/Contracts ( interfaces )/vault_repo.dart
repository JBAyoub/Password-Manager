import 'package:password/Models/vault.dart';

abstract interface class VaultRepo {
  // Return SecretKey
  Future<void> saveVault({required Vault vault});
  Future<Vault> loadVault();
  Future<void> deleteVault([int id = 1]);
}
