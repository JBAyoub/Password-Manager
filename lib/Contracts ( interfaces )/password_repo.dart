import 'package:password/Models/HashAlg.dart';
import 'package:password/Models/Password.dart';

abstract class PasswordRepo {
  Future<Password> getPasswordFromUsername(String username);
  Future<String> hash(Password password, Hashalg ha);
  Future<String> reverseHash(Password password, Hashalg ha);
  Future<int> duplicateCount(Password password);
}
