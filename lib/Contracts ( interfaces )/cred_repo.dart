import 'package:password/Models/Creds.dart';

abstract interface class CredRepo {
  Future<List<Creds>?> displayAll();
  Future<List<Creds>?> searchByWebsite({required String website});
  Future<List<Creds>?> searchByUsername({required String username});
  Future<void> addCred(Creds c);
  Future<void> delete(Creds c);
}
