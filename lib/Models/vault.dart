import 'package:cryptography/cryptography.dart';
import 'package:password/Models/Creds.dart';

class Vault {
  final int id;

  final List<int> salt;

  SecretKey? key;

  List<Creds>? credentials;

  Vault({required this.salt, required this.id, this.credentials, this.key});
}
