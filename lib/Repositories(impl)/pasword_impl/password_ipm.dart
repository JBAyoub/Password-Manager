import 'package:password/Contracts%20(%20interfaces%20)/password_repo.dart';
import 'package:password/Models/Password.dart';

class PasswordIpm implements PasswordRepo {
  @override
  Future<int> duplicateCount(Password password) {
    throw UnimplementedError();
  }

  @override
  Future<Password> getPasswordFromUsername(String username) {
    throw UnimplementedError();
  }
}
