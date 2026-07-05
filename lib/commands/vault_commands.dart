import 'package:args/args.dart';
import 'package:password/Services/vault_service.dart';

class Createvault {
  final ArgParser createCommand = ArgParser();
  final ArgParser fetchVaultCommand = ArgParser();
  final VaultService vaultService;
  Createvault(this.vaultService);
  ArgParser get vaultCreate => ArgParser()
    ..addCommand('create', createCommand)
    ..addOption(
      'master-password',
      abbr: 'm',
      help: 'The master password to encrypt the vault with',
      valueHelp: 'Master Password',
      mandatory: true,
    )
    ..addOption(
      'verification-text',
      abbr: 'v',
      help: 'The verification text to verify the vault',
      valueHelp: 'Verification Text',
    );

  ArgParser get vaultFetch => ArgParser()
    ..addCommand('fetch', fetchVaultCommand)
    ..addOption(
      'master-password',
      abbr: 'm',
      help: 'The master password to decrypt the vault with',
      valueHelp: 'Master Password',
      mandatory: true,
    );

  final ArgParser lockVault = ArgParser();
  ArgParser get vaultLock => ArgParser()..addCommand('lock', lockVault);

  Future<void> createVault(List<String>? args) async {
    if (args == null || args.isEmpty) {
      throw Exception("No arguments provided for fetching the vault.");
    }
    final ArgResults results = vaultCreate.parse(args);
    final String masterPassword = results['master-password'];
    final String verificationText =
        results['verification-text'] ??
        'YOU_REALLY_SHOULD_CHOOSE_A_STRONGER_VERIFICATION_TEXT';
    vaultService.createSecretKey(masterPassword);
    await vaultService.createVault(verificationText);
  }

  Future<void> fetchVault(List<String>? args) async {
    if (args == null || args.isEmpty) {
      throw Exception("No arguments provided for fetching the vault.");
    }

    final ArgResults results = vaultFetch.parse(args);
    final String masterPassword = results['master-password'];
    await vaultService.loadVault();
    await vaultService.unlockVault(masterPassword);
  }

  Future<void> deleteVault(List<String>? args) async {
    if (args == null || args.isEmpty) {
      throw Exception("No arguments provided for deleting the vault.");
    }
    await vaultService.loadVault();
    vaultService.lockVault();
  }
}
