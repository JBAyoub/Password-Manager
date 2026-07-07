import 'package:password/Data%20Sources/database_connection.dart';
import 'package:password/Repositories(impl)/cred_repo_impl/postgres_creds_imp.dart';
import 'package:password/Repositories(impl)/vault_impl/vault_impl.dart';
import 'package:password/Services/EncryptionService.dart';
import 'package:password/Services/creds_service.dart';
import 'package:password/Services/database_service.dart';
import 'package:password/Services/vault_service.dart';
import 'package:password/commands/command_runner.dart';
import 'package:password/commands/credentials_commands.dart';
import 'package:password/commands/vault_commands.dart';

void main(List<String>? arguments) async {
  final DatabaseConnection dbc = DatabaseConnection();
  final db = DatabaseService(connection: dbc);
  final vaultRepo = VaultImpl(db);
  final credentialRepo = PostgresCredsImp(db);
  final encryptionService = EncryptionService();
  final vaultService = VaultService(vaultRepo, encryptionService);
  final credentialService = CredsService(
    vaultService,
    credentialRepo,
    encryptionService,
  );
  final vaultCommands = VaultCommands(vaultService);
  final credentialCommands = CredentialCommands(
    vaultService,
    credentialService,
    encryptionService,
  );
  final commandRunner = CommandRunner(credentialCommands, vaultCommands);
  await commandRunner.run(arguments);
}
