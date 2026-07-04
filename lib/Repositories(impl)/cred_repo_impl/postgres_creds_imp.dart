import 'package:password/Contracts%20(%20interfaces%20)/cred_repo.dart';
import 'package:password/Models/Creds.dart';
import 'package:password/Services/database_service.dart';

class PostgresCredsImp implements CredRepo {
  DatabaseService dbService;
  PostgresCredsImp(this.dbService);
  @override
  Future<void> addCred(Creds c) async {
    await dbService.connect();
    await dbService.execute(
      '''
        INSERT INTO credentials (username, password, website, is_favorite)
        VALUES (\$1, \$2, \$3, \$4)
        ''',
      parameters: {
        'username': c.username,
        'password': c.p,
        'website': c.website,
        'is_favorite': c.id,
      },
    );
    await dbService.close();
  }

  @override
  Future<void> delete(Creds c) async {
    await dbService.connect();
    await dbService.execute(
      'DELETE FROM credentials WHERE id = \$1',
      parameters: {'id': c.id},
    );
    await dbService.close();
  }

  @override
  Future<List<Creds>?> displayAll() async {
    await dbService.connect();
    final result = await dbService.query('SELECT * FROM credentials');
    await dbService.close();
    return result
        .map((row) => Creds.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Creds>> importCreds() async {
    await dbService.connect();
    final result = await dbService.query('SELECT * FROM credentials');
    await dbService.close();
    return result
        .map((row) => Creds.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveCreds(List<Creds> listOfCredentials) async {
    await dbService.connect();
    for (var c in listOfCredentials) {
      await dbService.execute(
        '''
        INSERT INTO credentials (username, password, website, is_favorite)
        VALUES (\$1, \$2, \$3, \$4)
        ''',
        parameters: {
          'username': c.username,
          'password': c.p,
          'website': c.website,
          'is_favorite': c.id,
        },
      );
    }
    await dbService.close();
  }

  @override
  Future<Creds?> searchByUsername(String username) async {
    await dbService.connect();
    final result = await dbService.query(
      'SELECT * FROM credentials WHERE username = \$1',
      [username],
    );
    await dbService.close();
    return result.isEmpty
        ? null
        : Creds.fromJson(result.first as Map<String, dynamic>);
  }

  @override
  Future<Creds?> searchByWebsite(String website) async {
    await dbService.connect();
    final result = await dbService.query(
      'SELECT * FROM credentials WHERE website = \$1',
      [website],
    );
    await dbService.close();
    return result.isEmpty
        ? null
        : Creds.fromJson(result.first as Map<String, dynamic>);
  }

  @override
  Future<Creds?> searchCred(int id) async {
    await dbService.connect();
    final result = await dbService.query(
      'SELECT * FROM credentials WHERE id = \$1',
      [id],
    );
    await dbService.close();
    return result.isEmpty
        ? null
        : Creds.fromJson(result.first as Map<String, dynamic>);
  }

  @override
  Future<void> update(int id) async {
    await dbService.connect();
    final c = await searchCred(id);
    if (c == null) {
      throw Exception("Credential not found.");
    }
    await dbService.execute(
      'UPDATE credentials SET username = \$1, password = \$2, website = \$3, is_favorite = \$4 WHERE id = \$5',
      parameters: {
        'username': c.username,
        'password': c.p,
        'website': c.website,
        'id': id,
      },
    );
    await dbService.close();
  }
}
