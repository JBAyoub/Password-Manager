import 'package:password/Models/Creds.dart';
import 'package:password/Services/creds_service.dart';
import 'package:password/Services/password_service.dart';
import 'package:password/Services/vault_service.dart';
import 'package:args/args.dart';

class CredentialCommands {
  final VaultService vaultService;
  final PasswordService passwordService;
  final CredsService credsService;
  CredentialCommands(
    this.vaultService,
    this.passwordService,
    this.credsService,
  );

  final createParser = ArgParser()
    ..addOption('master-password', abbr: 'm', mandatory: true)
    ..addOption(abbr: 'u', 'username', mandatory: true)
    ..addOption(abbr: 'p', 'password', mandatory: true)
    ..addOption(abbr: 'w', 'website', mandatory: true);

  final displayParser = ArgParser()
    ..addOption('master-password', abbr: 'm', mandatory: true);

  Future<void> run(List<String>? args) async {
    print(displayParser.usage);
    print(createParser.usage);
    if (args == null || args.length < 2) {
      print('No vault command provided.');
      return;
    }

    switch (args[1]) {
      case 'create':
        await saveCredentials(args.sublist(1));
        break;
      case 'display':
        await displayCredentials(args.sublist(1));
    }
  }

  Future<void> saveCredentials(List<String>? args) async {
    if (args == null || args.length < 3) {
      throw Exception("No arguments provided for saving credentials.");
    }
    try {
      final ArgResults results = createParser.parse(args);
      final String username = results['username'];
      final String password = results['password'];
      final String website = results['website'];
      final encryptedPassword = await passwordService.encryptAndSavePassword(
        password,
        vaultService.currentKey!,
      );
      await credsService.addCred(
        Creds(p: encryptedPassword, username: username, website: website),
      );
    } on FormatException catch (e) {
      throw Exception("Error parsing arguments: ${e.message}");
    }
  }

  Future<void> displayCredentials(List<String> sublist) async {
    try {
      credsService.displayAll();
    } on FormatException catch (e) {
      print("Error displaying credentials: ${e.message}");
      print(displayParser.usage);
    }
  }
}
