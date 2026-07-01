import 'package:password/Models/Password.dart';
import 'package:password/Utils/enums.dart';

abstract class HashAlgRepo {
  Future<String> hashPassword(HashAlg ha, Password password);
  Future<Password> dehashPassword(HashAlg ha, String hashedPassword);
}
