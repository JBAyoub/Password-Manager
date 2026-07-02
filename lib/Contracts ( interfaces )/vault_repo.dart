import 'package:cryptography/cryptography.dart';

abstract interface class VaultRepo {
  // Generate vault salt
  Future<List<int>> generateSalt();
  // Store vault salt
  Future<void> saveSalt(List<int> salt);
  // Unlock vault
  Future<bool> unlockVault(String masterpassword);
  // Lock vault
  Future<bool> lockVault();
  // Return SecretKey
  Future<SecretKey> getSecretKey();
}
