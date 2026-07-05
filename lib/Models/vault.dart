import 'package:cryptography/cryptography.dart';

class Vault {
  final int id;

  final List<int> salt;

  final List<int> verificationCipherText;
  final List<int> verificationNonce;
  final List<int> verificationMac;

  Vault({
    required this.id,
    required this.salt,
    required this.verificationCipherText,
    required this.verificationNonce,
    required this.verificationMac,
  });

  factory Vault.fromJson(Map<String, dynamic> json) {
    return Vault(
      id: json['id'],
      salt: List<int>.from(json['salt']),
      verificationCipherText: List<int>.from(json['verificationCipherText']),
      verificationNonce: List<int>.from(json['verificationNonce']),
      verificationMac: List<int>.from(json['verificationMac']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'salt': salt,
      'verificationCipherText': verificationCipherText,
      'verificationNonce': verificationNonce,
      'verificationMac': verificationMac,
    };
  }
}
