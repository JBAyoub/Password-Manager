import 'package:password/Models/Creds.dart';

abstract interface class CredRepo {
  Future<Creds?> searchCred(int id);
  Future<List<Creds>?> displayAll();
  Future<Creds?> searchByWebsite(String website);
  Future<Creds?> searchByUsername(String username);
  Future<void> saveCreds(List<Creds> listOfCredentials);
  Future<List<Creds>> importCreds();
  Future<void> addCred(Creds c);
  Future<void> delete(Creds c);
  Future<void> update(int id);
}
