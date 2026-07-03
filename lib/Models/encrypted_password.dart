class EncryptedPassword {
  final String cipherText;
  final String nonce;
  final String mac;

  EncryptedPassword({
    required this.cipherText,
    required this.nonce,
    required this.mac,
  });

  // HashAlg get algorithmUsed => _algorithmUsed;
  // double calculateStrength(Password password) {
  //   return 5.0;
  // }
}
