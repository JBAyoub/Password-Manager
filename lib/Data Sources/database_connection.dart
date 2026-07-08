import 'dart:io';

import 'package:postgres/postgres.dart';

class DatabaseConnection {
  Connection? _connection;

  Future<void> connect() async {
    if (_connection != null) {
      return;
    }
    _connection = await Connection.open(
      Endpoint(
        host: Platform.environment['DB_HOST'] ?? 'localhost',
        port: int.parse(Platform.environment['DB_PORT'] ?? '5432'),
        database: Platform.environment['DB_NAME'] ?? 'password_manager',
        username: Platform.environment['DB_USER'] ?? 'postgres',
        password: Platform.environment['DB_PASSWORD'] ?? '',
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
