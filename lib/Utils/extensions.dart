import 'package:password/Utils/enums.dart';

extension HashAlgToString on HashAlg {
  static HashAlg parseString(String s) {
    switch (s.toLowerCase()) {
      case 'sha256':
        return HashAlg.sha256;
      case 'dartPack':
        return HashAlg.dartPack;
      default:
        return HashAlg.other;
    }
  }
}
