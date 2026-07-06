import 'dart:typed_data';

import 'package:password/Contracts%20(%20interfaces%20)/vault_repo.dart';
import 'package:password/Models/vault.dart';
import 'package:password/Services/database_service.dart';

class VaultImpl implements VaultRepo {
  final DatabaseService dbService;
  VaultImpl(this.dbService);

  @override
  Future<Vault> loadVault() async {
    final result = await dbService.query('SELECT * FROM vaults WHERE id = 1');
    if (result.isEmpty) {
      throw Exception("Vault not found.");
    }
    final row = result.first;

    return Vault(
      id: row[0] as int,
      salt: (row[1] as Uint8List).toList(),
      verificationCipherText: (row[2] as Uint8List).toList(),
      verificationNonce: (row[3] as Uint8List).toList(),
      verificationMac: (row[4] as Uint8List).toList(),
    );
  }

  @override
  Future<void> saveVault({required Vault vault}) async {
    await dbService.execute(
      '''
  INSERT INTO vaults (
      id,
      salt,
      verification_cipher,
      verification_nonce,
      verification_mac
  )
  VALUES (
      @id,
      @salt,
      @cipher,
      @nonce,
      @mac
  )
  ON CONFLICT (id)
  DO UPDATE SET
      salt = EXCLUDED.salt,
      verification_cipher = EXCLUDED.verification_cipher,
      verification_nonce = EXCLUDED.verification_nonce,
      verification_mac = EXCLUDED.verification_mac;
  ''',
      parameters: {
        'id': vault.id,
        'salt': Uint8List.fromList(vault.salt),
        'cipher': Uint8List.fromList(vault.verificationCipherText),
        'nonce': Uint8List.fromList(vault.verificationNonce),
        'mac': Uint8List.fromList(vault.verificationMac),
      },
    );
  }

  @override
  Future<void> deleteVault([int id = 1]) async {
    await dbService.execute(
      'DELETE FROM vaults WHERE id = @id',
      parameters: {'id': id},
    );
  }
}
