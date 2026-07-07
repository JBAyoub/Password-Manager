import 'package:password/Contracts%20(%20interfaces%20)/cred_repo.dart';
import 'package:password/Models/Creds.dart';

class LocalFileCredsImp implements CredRepo {
  @override
  Future<void> addCred(Creds c) {
    throw UnimplementedError();
  }

  @override
  Future<void> delete(Creds c) {
    throw UnimplementedError();
  }

  @override
  Future<List<Creds>?> displayAll() {
    throw UnimplementedError();
  }

  @override
  Future<List<Creds>?> searchByUsername({required String username}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Creds>?> searchByWebsite({required String website}) {
    throw UnimplementedError();
  }
}
