import 'package:password/Contracts%20(%20interfaces%20)/encryption_repo.dart';
import 'package:password/Services/vault_service.dart';

class EncryptionService {
  final EncryptionRepo encryptionRepo;
  final VaultService vs;
  EncryptionService(this.encryptionRepo, this.vs);
}
