import 'package:password/Models/Password.dart';

abstract interface class PasswordRepo {
  Future<Password> getPasswordFromUsername(String username);
  Future<int> duplicateCount(Password password);
}
