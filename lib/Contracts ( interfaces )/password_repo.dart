import 'package:password/Models/Creds.dart';
import 'package:password/Models/encrypted_password.dart';

abstract interface class PasswordRepo {
  Future<void> savePassword(EncryptedPassword password);
  Future<void> deletePassword(int id);
  Future<void> updatePassword(Creds creds, EncryptedPassword newPassword);
  Future<EncryptedPassword?> getPasswordById(int id);
}
