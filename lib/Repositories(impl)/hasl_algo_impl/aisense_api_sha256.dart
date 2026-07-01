import 'package:password/Contracts%20(%20interfaces%20)/hash_alg.repo.dart';
import 'package:password/Models/HashAlg.dart';
import 'package:password/Models/Password.dart';

class AisenseApiSha256 implements HashAlgRepo {
  @override
  Future<Password> dehashPassword(Hashalg ha, String hashedPassword) {
    throw UnimplementedError();
  }

  @override
  Future<String> hashPassword(Hashalg ha, Password password) {
    throw UnimplementedError();
  }
}
