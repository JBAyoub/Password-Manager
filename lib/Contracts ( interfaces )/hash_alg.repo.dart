import 'package:password/Models/HashAlg.dart';
import 'package:password/Models/Password.dart';

abstract class HashAlgRepo {
  Future<String> hashPassword(Hashalg ha, Password password);
  Future<Password> dehashPassword(Hashalg ha, String hashedPassword);
}
