import 'package:password/commands/credentials_commands.dart';
import 'package:password/commands/vault_commands.dart';

class CommandRunner {
  final CredentialCommands credentialsCommands;
  final VaultCommands vaultCommands;

  CommandRunner(this.credentialsCommands, this.vaultCommands);

  Future<void> run(List<String>? args) async {
    if (args == null || args.isEmpty) {
      print('No command provided.');
      return;
    }
    switch (args.first) {
      case 'vault':
        await vaultCommands.run(args);
      default:
        print('Unknown command: $args');
    }
  }
}
