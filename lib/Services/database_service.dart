import 'dart:io';
import 'package:password/Data%20Sources/database_connection.dart';

class DatabaseService {
  final DatabaseConnection connection;
  DatabaseService({required this.connection});
  Future<void> connect() async {
    await connection.connect();
  }

  Future<void> close() async {
    await connection.close();
  }

  Future<void> initializeDatabase() async {
    final migrationsDir = Directory('lib/Data Sources/database_migrations');

    if (!await migrationsDir.exists()) {
      print('Migrations directory not found: ${migrationsDir.path}');
      return;
    }

    final entries = await migrationsDir
        .list()
        .where((e) => e is File && e.path.endsWith('.sql'))
        .cast<File>()
        .toList();
    if (entries.isEmpty) return;

    entries.sort((a, b) => a.path.compareTo(b.path));

    for (final file in entries) {
      final sql = await file.readAsString();
      if (sql.trim().isEmpty) continue;
      try {
        await connection.connection.execute(sql);
        final name = file.path.split(RegExp(r'[\\/]')).last;
        print('Applied migration: $name');
      } catch (e) {
        print('Failed to apply migration ${file.path}: $e');
        rethrow;
      }
    }
  }
}
