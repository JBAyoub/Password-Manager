import 'package:password/Contracts%20(%20interfaces%20)/hash_alg.repo.dart';
import 'package:password/Utils/enums.dart';
import 'package:password/Models/Password.dart';

class LocalHashAlg implements HashAlgRepo {
  @override
  Future<Password> dehashPassword(HashAlg ha, String hashedPassword) {
    throw UnimplementedError();
  }

  @override
  Future<String> hashPassword(HashAlg ha, Password password) {
    throw UnimplementedError();
  }
}
