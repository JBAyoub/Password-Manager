import 'package:password/Utils/enums.dart';

class Password {
  late final String _hashed;
  final HashAlg _algorithmUsed;
  final double passwordStrength;

  Password({
    required this._hashed,
    required this._algorithmUsed,
    required this.passwordStrength,
  });

  // ignore: unnecessary_getters_setters
  String get hashed => _hashed;
  // ignore: unused_element
  set _algorithmUsed(HashAlg ha) {
    _algorithmUsed = ha;
  }

  set hashed(String s) {
    _hashed = s;
  }

  HashAlg get algorithmUsed => _algorithmUsed;
  double calculateStrength(Password password) {
    return 5.0;
  }
}
