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
  Future<List<Creds>> importCreds() {
    throw UnimplementedError();
  }

  @override
  Future<void> saveCreds(List<Creds> listOfCredentials) {
    throw UnimplementedError();
  }

  @override
  Future<Creds?> searchByUsername(String username) {
    throw UnimplementedError();
  }

  @override
  Future<Creds?> searchByWebsite(String website) {
    throw UnimplementedError();
  }

  @override
  Future<Creds?> searchCred(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> update(int id) {
    throw UnimplementedError();
  }
}
