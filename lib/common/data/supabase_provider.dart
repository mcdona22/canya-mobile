import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabaseClientProvider = Provider<SupabaseClient>((
  ref,
) {
  return Supabase.instance.client;
});

// final localDataBaseProvider = Provider<Database>((ref) {
//   final dbFileName = 'canya-local-db';
//
//   late Database _database;
//
//   Future _createDb(Database db, int version) async {
//     const idType = 'TEXT_PRIMARY_KEY';
//     const textType = 'TEXT NOT NULL';
//
//     await db.execute('''
//       CREATE TABLE canya_event (
//         id $idType,
//         name $textType,
//         description TEXT
//       )
//     ''');
//   }
//
//   _init() async {
//     final dbPath = await getDatabasesPath();
//     final dbName = 'canya';
//
//     final path = join(dbPath, dbName);
//     _database = await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDb,
//     );
//   }
// });
