import 'package:args/args.dart';
import 'package:password/Services/vault_service.dart';

class VaultCommands {
  final VaultService vaultService;
  VaultCommands(this.vaultService);
  final createParser = ArgParser()
    ..addOption('master-password', abbr: 'm', mandatory: true);

  final unlockParser = ArgParser()
    ..addOption('master-password', abbr: 'm', mandatory: true);

  Future<void> run(List<String>? args) async {
    if (args == null || args.length < 2) {
      print('No vault command provided.');
      return;
    }

    switch (args[1]) {
      case 'create':
        await createVault(args.sublist(2));
        break;

      case 'unlock':
        await unlockVault(args.sublist(2));
        break;
      default:
        print('Unknown vault command.');
    }
  }

  Future<void> createVault(List<String> args) async {
    try {
      final results = createParser.parse(args);
      final masterPassword = results['master-password'] as String;
      await vaultService.createVault(masterPassword);

      print("Vault created.");
    } on FormatException catch (e) {
      print(e.message);
      print(createParser.usage);
    }
  }

  Future<void> unlockVault(List<String> args) async {
    try {
      final results = unlockParser.parse(args);
      final masterPassword = results['master-password'] as String;
      await vaultService.unlockVault(masterPassword);
    } on FormatException catch (e) {
      print("Error unlocking vault: ${e.message}");
      print(unlockParser.usage);
    }
  }
}
