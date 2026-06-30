import 'package:password/Models/Creds.dart';

abstract class CredRepo {
  Future<Creds?> searchCred(int id);
  Future<List<Creds>?> displayAll();
  Future<List<Creds>?> getFavorties();
  Future<Creds?> searchByWebsite(String website);
  Future<Creds?> searchByUsername(String username);
  Future<void> saveCreds(List<Creds> listOfCredentials);
  Future<List<Creds>> importCreds();
  Future<void> addCred(Creds c);
  Future<void> delete(Creds c);
  Future<void> update(int id);
}
