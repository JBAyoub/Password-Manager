import 'package:password/Models/Creds.dart';

class Vault {
  final int id;
  final List<int> salt;
  final List<Creds>? credentials;

  Vault({required this.salt, required this.id, this.credentials});
}
