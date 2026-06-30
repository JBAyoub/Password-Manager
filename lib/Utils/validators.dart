import 'dart:convert';
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

  static Future<Map<String, dynamic>> jsonToMap() async {
    final File f = File('data/data.json');
    final File data = await getJsonFile(f);
    final Map<String, dynamic> passes =
        jsonDecode(data.readAsStringSync()) as Map<String, dynamic>;
    return passes;
  }
}
