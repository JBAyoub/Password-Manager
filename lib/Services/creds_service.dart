import 'package:password/Contracts%20(%20interfaces%20)/cred_repo.dart';
import 'package:password/Models/Creds.dart';

class CredsService {
  final CredRepo _credRepo;
  CredsService(this._credRepo);

  Future<void> addCred(Creds c) async {
    await _credRepo.addCred(c);
  }
}
