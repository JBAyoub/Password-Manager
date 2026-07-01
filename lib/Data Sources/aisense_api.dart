import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class AisenseApi {
  Future<String?> getAiSenseHash(String s) async {
    final uri = Uri.https("aisenseapi.com", '/services/v1/sha256_hash');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode([
        {'data': s},
      ]),
    );
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      return json['sha256_hash'];
    }
    return null;
  }
}
