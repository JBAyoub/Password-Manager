import 'package:password/Contracts%20(%20interfaces%20)/password_repo.dart';
import 'package:password/Models/Creds.dart';
import 'package:password/Models/encrypted_password.dart';
import 'package:password/Services/database_service.dart';

class PasswordIpm implements PasswordRepo {
  DatabaseService dbService;
  PasswordIpm(this.dbService);
  @override
  Future<void> deletePassword(int id) async {
    await dbService.connect();
    await dbService.execute(
      'DELETE FROM passwords WHERE id = \$1',
      parameters: {'id': id},
    );
    await dbService.close();
  }

  @override
  Future<EncryptedPassword?> getPasswordById(int id) async {
    await dbService.connect();
    final result = await dbService.query(
      'SELECT * FROM passwords WHERE id = \$1',
      [id],
    );
    await dbService.close();

    if (result.isEmpty) {
      return null;
    }

    final row = result.first;
    return EncryptedPassword(
      id: int.parse(row[0]['id'] as String),
      cipherText: row[0]['cipherText'],
      nonce: row[0]['nonce'],
      mac: row[0]['mac'],
    );
  }

  @override
  Future<void> savePassword(EncryptedPassword password) async {
    await dbService.connect();
    await dbService.execute(
      'INSERT INTO passwords (id, cipherText, nonce, mac) VALUES (\$1, \$2, \$3, \$4)',
      parameters: {
        'id': password.id,
        'cipherText': password.cipherText,
        'nonce': password.nonce,
        'mac': password.mac,
      },
    );
    await dbService.close();
  }

  @override
  Future<void> updatePassword(
    Creds creds,
    EncryptedPassword newPassword,
  ) async {
    throw UnimplementedError();
  }
}
