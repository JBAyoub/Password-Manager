class EncryptedPassword {
  final String cipherText;
  final String nonce;
  final String mac;

  EncryptedPassword({
    required this.cipherText,
    required this.nonce,
    required this.mac,
  });

  factory EncryptedPassword.fromJson(Map<String, dynamic> json) {
    return EncryptedPassword(
      cipherText: json['cipherText'],
      nonce: json['nonce'],
      mac: json['mac'],
    );
  }
  Map<String, String> toJson() {
    return {'cipherText': cipherText, 'nonce': nonce, 'mac': mac};
  }
}
