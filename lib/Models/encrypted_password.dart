class EncryptedPassword {
  final List<int> cipherText;
  final List<int> nonce;
  final List<int> mac;

  EncryptedPassword({
    required this.cipherText,
    required this.nonce,
    required this.mac,
  });

  factory EncryptedPassword.fromJson(Map<String, dynamic> json) {
    return EncryptedPassword(
      cipherText: json['cipherText'] as List<int>,
      nonce: json['nonce'] as List<int>,
      mac: json['mac'] as List<int>,
    );
  }
  Map<String, List<int>> toJson() {
    return {'cipherText': cipherText, 'nonce': nonce, 'mac': mac};
  }
}
