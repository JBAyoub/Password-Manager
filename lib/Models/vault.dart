import 'package:cryptography/cryptography.dart';

class Vault {
  final int id;

  final List<int> salt;

  SecretKey? key;

  final List<int> verificationCipherText;
  final List<int> verificationNonce;
  final List<int> verificationMac;

  Vault({
    required this.id,
    required this.salt,
    this.key,
    required this.verificationCipherText,
    required this.verificationNonce,
    required this.verificationMac,
  });
}
