import 'package:password/Contracts%20(%20interfaces%20)/cred_repo.dart';
import 'package:password/Models/Creds.dart';
import 'package:password/Models/encrypted_password.dart';
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
  Future<void> delete(Creds c) async {
    throw UnimplementedError();
  }

  @override
  Future<List<Creds>?> displayAll() async {
    final result = await dbService.query('SELECT * FROM credentials');
    return result.map((row) {
      final values = row as List<dynamic>;
      return Creds(
        p: EncryptedPassword(
          id: values[0] as int,
          cipherText: (values[3] as List<dynamic>)
              .map((e) => e as int)
              .toList(),
          nonce: (values[4] as List<dynamic>).map((e) => e as int).toList(),
          mac: (values[5] as List<dynamic>).map((e) => e as int).toList(),
        ),
        username: values[2].toString(),
        website: values[1].toString(),
      );
    }).toList();
  }

  @override
  Future<List<Creds>> importCreds() async {
    final result = await dbService.query('SELECT * FROM credentials');
    return result
        .map((row) => Creds.fromJson(row as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<void> saveCreds(List<Creds> listOfCredentials) async {
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
        },
      );
    }
  }

  @override
  Future<Creds?> searchByUsername(String username) async {
    final result = await dbService.query(
      'SELECT * FROM credentials WHERE username = \$1',
      [username],
    );
    return result.isEmpty
        ? null
        : Creds.fromJson(result.first as Map<String, dynamic>);
  }

  @override
  Future<Creds?> searchByWebsite(String website) async {
    final result = await dbService.query(
      'SELECT * FROM credentials WHERE website = \$1',
      [website],
    );
    return result.isEmpty
        ? null
        : Creds.fromJson(result.first as Map<String, dynamic>);
  }

  @override
  Future<Creds?> searchCred(int id) async {
    final result = await dbService.query(
      'SELECT * FROM credentials WHERE id = \$1',
      [id],
    );
    return result.isEmpty
        ? null
        : Creds.fromJson(result.first as Map<String, dynamic>);
  }

  @override
  Future<void> update(int id) async {
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
  }
}
