import 'dart:io';

abstract class Validators {
  static Future<bool> fileExists(File f) async => await f.exists();
  static Future<void> createDataFile(File f) async =>
      await f.create(recursive: true);

  static Future<File> getJsonFile(File f) async {
    if (!await fileExists(f)) {
      createDataFile(f);
    }
    return f;
  }

  static bool isValidSha256(String s) {
    final regEx = RegExp(r'^[a-fA-F0-9]{64}$');
    return regEx.hasMatch(s);
  }
}
