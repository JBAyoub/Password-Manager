import 'package:password/Models/HashAlg.dart';

abstract class HashAlgRepo {
  Future<Hashalg> getAlgorithm(int id);
  Future<String> applyAlgorithm(String password);
  Future<void> addAlg(Hashalg ha);
}
