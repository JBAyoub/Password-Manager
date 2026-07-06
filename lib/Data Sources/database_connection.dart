import 'package:postgres/postgres.dart';

class DatabaseConnection {
  Connection? _connection;
  Future<void> connect() async {
    if (_connection != null) {
      print("Database is already connected.");
      return;
    }
    print("Connecting to the database...");
    _connection = await Connection.open(
      Endpoint(
        host: 'localhost',
        port: 5432,
        database: 'password_manager',
        username: 'postgres',
        password: 'takhrafih',
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
