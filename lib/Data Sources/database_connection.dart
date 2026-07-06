import 'package:postgres/postgres.dart';

class DatabaseConnection {
  late final Connection connection;

  Future<Connection> connect() async {
    connection = await Connection.open(
      Endpoint(
        host: 'localhost',
        port: 5432,
        database: 'password_manager',
        username: 'postgres',
        password: 'takhrafih',
      ),
      settings: const ConnectionSettings(sslMode: SslMode.disable),
    );
    return connection;
  }

  Future<void> close() async {
    await connection.close(force: true);
  }
}
