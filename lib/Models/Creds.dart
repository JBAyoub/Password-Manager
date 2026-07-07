import 'package:password/Models/encrypted_password.dart';
import 'package:postgres/postgres.dart';

class Creds {
  int? id;

  final EncryptedPassword _p;
  String username;
  String website;

  Creds({
    this.id,
    required this._p,
    required this.username,
    required this.website,
  });

  EncryptedPassword get p => _p;

  factory Creds.fromJson(Map<String, dynamic> json) {
    return Creds(
      p: EncryptedPassword.fromJson(
        json['encrypted_password'] as Map<String, dynamic>,
      ),
      username: json['username'].toString(),
      website: json['website'].toString(),
    );
  }
  factory Creds.fromRow(ResultRow row) {
    final values = row as List<dynamic>;
    return Creds(
      id: values[0] as int,
      p: EncryptedPassword(
        cipherText: (values[3] as List<dynamic>).map((e) => e as int).toList(),
        nonce: (values[4] as List<dynamic>).map((e) => e as int).toList(),
        mac: (values[5] as List<dynamic>).map((e) => e as int).toList(),
      ),
      username: values[2].toString(),
      website: values[1].toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'encrypted_password': _p.toJson(),
      'username': username,
      'website': website,
    };
  }

  @override
  String toString() {
    return '''---------------------------------\nWebsite: $website | Username: $username\n---------------------------------''';
  }
}
