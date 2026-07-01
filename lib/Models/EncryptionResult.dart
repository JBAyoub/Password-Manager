import 'package:cryptography/cryptography.dart';

class EncryptionResult {
  final SecretBox secretBox;
  final List<int> salt;

  EncryptionResult({required this.secretBox, required this.salt});
}
