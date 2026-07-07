import 'package:postgres/postgres.dart';
import 'package:dotenv/dotenv.dart';

class DatabaseConnection {
  Connection? _connection;
  final _requiredEnvVars = ['host', 'port', 'database', 'username', 'password'];
  bool get hasEnv => env.isEveryDefined(_requiredEnvVars);
  var env = DotEnv(includePlatformEnvironment: true)..load();

  Future<void> connect() async {
    if (_connection != null) {
      print("Database is already connected.");
      return;
    }
    if (hasEnv) {
      _connection = await Connection.open(
        Endpoint(
          host: env['host']!,
          port: int.parse(env['port']!),
          database: env['database']!,
          username: env['username']!,
          password: env['password']!,
        ),
        settings: const ConnectionSettings(sslMode: SslMode.disable),
      );
    }
  }

  Connection get connection {
    if (_connection == null) {
      throw Exception("Database has not been connected.");
    }
    return _connection!;
  }

  Future<void> close() async {
    await _connection?.close();
    _connection = null;
  }
}
