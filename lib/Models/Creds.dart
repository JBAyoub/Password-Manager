import 'package:password/Models/Password.dart';
import 'package:password/Utils/extensions.dart';

class Creds {
  final int _id;
  final Password _p;
  String username;
  String website;

  Creds({
    required this._id,
    required this._p,
    required this.username,
    required this.website,
  });

  int get id => _id;
  Password get p => _p;

  factory Creds.fromJson(Map<String, dynamic> json) {
    return Creds(
      id: json['id'] as int,
      p: Password(
        hashed: json['hashed_password'].toString(),
        algorithmUsed: HashAlgToString.parseString(json['used_alg'].toString()),
        passwordStrength: double.tryParse(json['calculcated_strength']) ?? 0.0,
      ),
      username: json['username'].toString(),
      website: json['website'].toString(),
    );
  }
}
