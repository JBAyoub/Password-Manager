import 'package:password/Models/HashAlg.dart';

class Password {
  final String _hashed;
  final Hashalg _algorithmUsed;
  final double passwordStrength;

  Password({
    required this._hashed,
    required this._algorithmUsed,
    required this.passwordStrength,
  });

  String get hashed => _hashed;
  // ignore: unused_element
  set _algorithmUsed(Hashalg ha) {
    _algorithmUsed = ha;
  }

  Hashalg get algorithmUsed => _algorithmUsed;
}
