import 'package:postgres/postgres.dart';
import 'package:dotenv/dotenv.dart';

class DatabaseConnection {
  Connection? _connection;

  Future<void> connect() async {
    if (_connection != null) return;
    var env = DotEnv(includePlatformEnvironment: true)..load();
    _connection = await Connection.open(
      Endpoint(
        host: env['DB_HOST'] ?? 'localhost',
        port: int.parse(env['DB_PORT'] ?? '5432'),
        database: env['DB_NAME'] ?? 'password_manager',
        username: env['DB_USER'] ?? 'postgres',
        password: env['DB_PASSWORD'] ?? '',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
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
