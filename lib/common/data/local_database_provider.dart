import 'package:canya/common/ddl/sqflite.sql.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final localDatabaseProvider = Provider<Database>((ref) {
  throw UnimplementedError(
    'to be overridden in main() provider',
  );
});

Future<Database> initDatabase() async {
  final dbPath = await getDatabasesPath();
  final dbName = 'canya-db';
  final path = join(dbPath, dbName);

  return await openDatabase(
    path,
    version: 2,
    onCreate: (db, version) async {
      await db.execute(schemaDdl);
    },
  );
}
