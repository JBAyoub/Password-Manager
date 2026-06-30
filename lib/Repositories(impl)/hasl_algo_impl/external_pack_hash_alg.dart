import 'package:password/Contracts%20(%20interfaces%20)/hash_alg.repo.dart';
import 'package:password/Models/HashAlg.dart';

class ExternalPackHashAlg implements HashAlgRepo {
  @override
  Future<void> addAlg(Hashalg ha) {
    throw UnimplementedError();
  }

  @override
  Future<String> applyAlgorithm(String password) {
    throw UnimplementedError();
  }

  @override
  Future<Hashalg> getAlgorithm(int id) {
    throw UnimplementedError();
  }
}
