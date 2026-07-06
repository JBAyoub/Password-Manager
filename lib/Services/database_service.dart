import 'package:password/Data%20Sources/database_connection.dart';
import 'package:postgres/postgres.dart';

class DatabaseService {
  final DatabaseConnection connection;
  DatabaseService({required this.connection});

  Future<Result> query(String sql, [List<dynamic>? params]) async {
    await connection.connect(); // Ensure the connection is established
    final results = await connection.connection.execute(
      Sql.named(sql),
      parameters: params,
    );
    await connection.close(); // Close the connection after the query
    return results;
  }

  Future<void> execute(
    String sql, {
    Map<String, dynamic> parameters = const {},
  }) async {
    await connection.connect(); // Ensure the connection is established
    await connection.connection.execute(Sql.named(sql), parameters: parameters);
    await connection.close(); // Close the connection after the execution
  }
}
