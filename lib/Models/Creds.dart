import 'package:password/Models/encrypted_password.dart';

class Creds {
  final EncryptedPassword _p;
  String username;
  String website;

  Creds({required this._p, required this.username, required this.website});

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
