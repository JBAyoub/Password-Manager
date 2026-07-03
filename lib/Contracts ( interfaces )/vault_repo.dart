import 'package:password/Models/vault.dart';

abstract interface class VaultRepo {
  // Store vault salt
  Future<void> saveSalt({required List<int> salt});
  // Return SecretKey
  Future<void> saveVault({required Vault vault});
  Future<Vault> loadVault();
}
