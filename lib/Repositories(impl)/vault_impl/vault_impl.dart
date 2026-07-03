import 'package:password/Contracts%20(%20interfaces%20)/vault_repo.dart';
import 'package:password/Models/vault.dart';
import 'package:password/Services/database_service.dart';

class VaultImpl implements VaultRepo {
  final DatabaseService db;
  VaultImpl(this.db);
  String toHex(List<int> bytes) =>
      bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  @override
  Future<void> saveSalt({required List<int> salt}) async {
    final conn = db.connection.connection;
    final saltHex = toHex(salt);
    await conn.execute("""
      UPDATE vaults
      SET salt = decode('$saltHex', 'hex')
      WHERE id = (SELECT id FROM vaults LIMIT 1)
    """);
  }

  @override
  Future<void> saveVault({required Vault vault}) async {
    final conn = db.connection.connection;
    final saltHex = toHex(vault.salt);
    final cipherHex = toHex(vault.verificationCipherText);
    final nonceHex = toHex(vault.verificationNonce);
    final macHex = toHex(vault.verificationMac);

    final sql =
        """
      BEGIN;
      DELETE FROM vaults;
      INSERT INTO vaults (salt, verification_cipher, verification_nonce, verification_mac)
      VALUES (
        decode('$saltHex','hex'),
        decode('$cipherHex','hex'),
        decode('$nonceHex','hex'),
        decode('$macHex','hex')
      );
      COMMIT;
    """;

    await conn.execute(sql);
  }

  @override
  Future<Vault> loadVault() async {
    final conn = db.connection.connection;
    final results = await conn.execute('''
      SELECT id, salt, verification_cipher, verification_nonce, verification_mac
      FROM vaults
      ORDER BY id
      LIMIT 1
    ''');

    if (results.isEmpty) {
      throw Exception('Vault not found in database.');
    }

    final row = results.first;
    final id = row[0] as int;
    final salt = (row[1] as List).cast<int>();
    final verificationCipher = (row[2] as List).cast<int>();
    final verificationNonce = (row[3] as List).cast<int>();
    final verificationMac = (row[4] as List).cast<int>();

    return Vault(
      id: id,
      salt: salt,
      key: null,
      verificationCipherText: verificationCipher,
      verificationNonce: verificationNonce,
      verificationMac: verificationMac,
    );
  }
}
