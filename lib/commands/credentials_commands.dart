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
  ArgParser saveCommand = ArgParser();
  ArgParser get saveCredentials => ArgParser()
    ..addOption(
      'username',
      abbr: 'u',
      help: 'The username to save',
      valueHelp: 'Username',
      mandatory: true,
    )
    ..addOption(
      'password',
      abbr: 'p',
      help: 'The password to save',
      valueHelp: 'Password',
      mandatory: true,
    )
    ..addOption(
      'website',
      abbr: 'w',
      help: 'The website to save the credentials for',
      valueHelp: 'Website',
      mandatory: true,
    )
    ..addCommand('save', saveCommand);

  Future<void> saveCredentialsCommand(List<String>? args) async {
    if (args == null || args.length < 3) {
      throw Exception("No arguments provided for saving credentials.");
    }
    try {
      final ArgResults results = saveCredentials.parse(args);
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
}
