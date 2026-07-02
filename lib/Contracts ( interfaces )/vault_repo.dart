import 'package:cryptography/cryptography.dart';

abstract interface class VaultRepo {
  // Store vault salt
  Future<void> saveSalt(List<int> salt);
  // Return SecretKey
  Future<SecretKey> getSecretKey();
}
