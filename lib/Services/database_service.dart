import 'package:password/Data%20Sources/database_connection.dart';
import 'package:postgres/postgres.dart';

class DatabaseService {
  final DatabaseConnection connection;
  DatabaseService({required this.connection});
  Future<void> connect() async => await connection.connect();

  Future<void> close() async => await connection.close();

  Future<List<List<dynamic>>> query(String sql, [List<dynamic>? params]) async {
    final conn = await connection.connect();

    return await conn.execute(sql, parameters: params);
  }

  Future<void> execute(
    String sql, {
    Map<String, dynamic> parameters = const {},
  }) async {
    final conn = await connection.connect();

    await conn.execute(Sql.named(sql), parameters: parameters);

    await connection.close();
  }
}
