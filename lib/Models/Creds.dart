import 'package:password/Models/Password.dart';

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
}
