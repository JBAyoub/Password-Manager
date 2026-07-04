import 'dart:convert';

import 'package:password/Contracts%20(%20interfaces%20)/vault_repo.dart';
import 'package:password/Models/vault.dart';
import 'package:password/Services/database_service.dart';

class VaultImpl implements VaultRepo {
  final DatabaseService dbService;
  VaultImpl(this.dbService);

  @override
  Future<Vault> loadVault() async {
    await dbService.connect();
    final result = await dbService.query(
      'SELECT payload FROM vault WHERE id = 1',
    );
    await dbService.close();
    if (result.isEmpty) {
      throw Exception("Vault not found.");
    }
    final payload = result.first[0] as String;
    final vaultJson = jsonDecode(payload);
    await dbService.close();
    return Vault.fromJson(vaultJson);
  }

  @override
  Future<void> saveVault({required Vault vault}) async {
    await dbService.connect();
    final payload = jsonEncode(vault.toJson());
    await dbService.execute(
      '''
      INSERT INTO vault (id, payload)
      VALUES (1, \$1)
      ON CONFLICT (id) DO UPDATE SET
        payload = EXCLUDED.payload
      ''',
      parameters: {'payload': payload},
    );
    await dbService.close();
  }

  @override
  Future<void> deleteVault([int id = 1]) async {
    await dbService.connect();
    await dbService.execute(
      'DELETE FROM vault WHERE id = \$1',
      parameters: {'id': id},
    );
    await dbService.close();
  }
}
