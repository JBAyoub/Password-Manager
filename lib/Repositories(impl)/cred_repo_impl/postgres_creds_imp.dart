import 'package:password/Contracts%20(%20interfaces%20)/cred_repo.dart';
import 'package:password/Models/Creds.dart';
import 'package:password/Services/database_service.dart';

class PostgresCredsImp implements CredRepo {
  DatabaseService dbService;
  PostgresCredsImp(this.dbService);
  @override
  Future<void> addCred(Creds c) async {
    await dbService.execute(
      '''
       INSERT INTO credentials (
      website,
      username,
      cipher_text,
      nonce,
      mac
  )
  VALUES (
      @website,
      @username,
      @cipherText,
      @nonce,
      @mac
  )
        ''',
      parameters: {
        'website': c.website,
        'username': c.username,
        'cipherText': c.p.cipherText,
        'nonce': c.p.nonce,
        'mac': c.p.mac,
      },
    );
  }

  @override
  Future<void> delete({required int id}) async {
    await dbService.execute(
      '''delete FROM credentials WHERE id = @id''',
      parameters: {'id': id},
    );
  }

  @override
  Future<List<Creds>?> displayAll() async {
    final result = await dbService.query('SELECT * FROM credentials');
    return result.map(Creds.fromRow).toList();
  }

  @override
  Future<List<Creds>?> searchByUsername({required String username}) async {
    final result = await dbService.query(
      'SELECT * FROM credentials WHERE username LIKE @username',
      parameters: {'username': '%$username%'},
    );
    return result.map(Creds.fromRow).toList();
  }

  @override
  Future<List<Creds>?> searchByWebsite({required String website}) async {
    final result = await dbService.query(
      'SELECT * FROM credentials WHERE website LIKE @website',
      parameters: {'website': '%$website%'},
    );
    return result.map(Creds.fromRow).toList();
  }

  @override
  Future<Creds?> searchById({required int id}) async {
    final result = await dbService.query(
      '''SELECT * FROM credentials WHERE id=@id''',
      parameters: {'id': id},
    );
    if (result.isEmpty) {
      return null;
    }
    final row = result.first;
    return Creds.fromRow(row);
  }
}
