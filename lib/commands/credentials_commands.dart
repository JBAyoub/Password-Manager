import 'dart:io';

import 'package:password/Models/Creds.dart';
import 'package:password/Services/EncryptionService.dart';
import 'package:password/Services/creds_service.dart';
import 'package:password/Services/vault_service.dart';
import 'package:args/args.dart';

class CredentialCommands {
  final VaultService vaultService;
  final CredsService credsService;
  final EncryptionService encryptionService;
  CredentialCommands(
    this.vaultService,
    this.credsService,
    this.encryptionService,
  );

  final createParser = ArgParser()
    ..addOption('master-password', abbr: 'm', mandatory: true)
    ..addOption(abbr: 'u', 'username', mandatory: true)
    ..addOption(abbr: 'p', 'password', mandatory: true)
    ..addOption(abbr: 'w', 'website', mandatory: true);

  final displayParser = ArgParser()
    ..addOption('master-password', abbr: 'm', mandatory: true);

  final searchParser = ArgParser()
    ..addOption('master-password', abbr: 'm', mandatory: true)
    ..addOption("website", abbr: "w")
    ..addOption("username", abbr: "u");

  final deleteParser = ArgParser()
    ..addOption("master-password", abbr: "m", mandatory: true)
    ..addOption("id", abbr: "i");

  Future<void> run(List<String>? args) async {
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
        break;
      case 'search':
        await searchCredentials(args.sublist(1));
        break;
      case 'delete':
        await deleteCredentials(args.sublist(1));
        break;
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
      await vaultService.unlockVault(results['master-password']);

      final encryptedPassword = await encryptionService.encrypt(
        password: password,
        key: vaultService.currentKey!,
      );
      await credsService.addCred(
        Creds(p: encryptedPassword, username: username, website: website),
      );
    } on FormatException catch (e) {
      throw Exception("Error parsing arguments: ${e.message}");
    }
    print("Credentials saved successfully.");
  }

  Future<void> displayCredentials(List<String> args) async {
    try {
      final ArgResults results = displayParser.parse(args);
      await vaultService.unlockVault(results['master-password']);
      await credsService.displayAll();
    } on FormatException catch (e) {
      print("Error displaying credentials: ${e.message}");
      print(displayParser.usage);
    }
  }

  Future<void> searchCredentials(List<String>? args) async {
    if (args == null || args.isEmpty) {
      print("No arguments were provided for the search.");
      print(searchParser.usage);
      return;
    }
    final ArgResults results = searchParser.parse(args);
    await vaultService.unlockVault(results['master-password']);
    if (results['username'] == null && results['website'] == null ||
        (results['username'] != null && results['website'] != null)) {
      print("Please search by either 'Website' or 'Username'");
      return;
    }
    if (results['username'] != null) {
      await credsService.searchByUsername(username: results['username']);
      return;
    } else {
      await credsService.searchByWebsite(website: results['website']);
    }
  }

  Future<void> deleteCredentials(List<String>? args) async {
    if (args == null || args.isEmpty) {
      print("No arguments were provided for the search.");
      print(deleteParser.usage);
      return;
    }
    final ArgResults results = deleteParser.parse(args);
    await vaultService.unlockVault(results['master-password']);
    await credsService.displayAll();
    final int id;
    id = int.tryParse(results['id']) ?? askForId();
    final creds = await credsService.searchById(id);
    if (creds != null) {
      await credsService.deleteCred(id: id);
      await credsService.displayAll();
      return;
    } else {
      print("Credential doesn't exist.");
      return;
    }
  }

  int askForId() {
    String? input;
    do {
      print("Please choose an ID");
      input = stdin.readLineSync();
    } while (input == '' || input == null || int.tryParse(input) == null);
    return int.parse(input);
  }
}
