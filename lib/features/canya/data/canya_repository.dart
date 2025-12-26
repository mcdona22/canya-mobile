import 'package:canya/common/data/local_database_provider.dart';
import 'package:canya/common/data/supabase_provider.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

import 'canya_event.dart';

part 'canya_repository.g.dart';

typedef JsonList = List<Map<String, dynamic>>;

@Riverpod()
CanyaRepository canyaRepository(Ref ref) => CanyaRepository(
  client: ref.watch(supabaseClientProvider),
  localDatabase: ref.watch(localDatabaseProvider),
);

class CanyaRepository with UiLoggy {
  final tableName = 'canya_event';
  final withSlotsView = 'canya_event_with_slots';

  CanyaRepository({
    required this.client,
    required this.localDatabase,
  });

  final SupabaseClient client;
  final Database localDatabase;

  Stream<List<CanyaEvent>> fetchAll() {
    final response = client
        .from(tableName)
        .stream(primaryKey: ['id'])
        .order('name', ascending: true)
        .map(
          (data) => data
              .map((json) => CanyaEvent.fromMap(json))
              .toList(),
        );

    return response;
  }

  Stream<CanyaEvent> fetchById(String id) {
    final Stream<CanyaEvent> response = client
        .from(withSlotsView)
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((data) {
          if (data.isEmpty) {
            throw Exception('No Canya with an id of $id');
          }
          return CanyaEvent.fromMap(data.first);
        });
    loggy.info('With the slots', response);

    return response;
  }

  Future<CanyaEvent> createCanya(CanyaEvent c) async {
    final id = const Uuid().v4();
    final entry = CanyaEvent.fromMap({
      ...c.toMap(),
      'id': id,
    });

    try {
      loggy.info('The map being passed is : ', entry);
      await localDatabase.insert(
        tableName,
        entry.toTableMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      // final response = await client
      //     .from(tableName)
      //     .upsert(data)
      //     .select()
      //     .single();
      // final canya = CanyaEvent.fromMap(response.);
      loggy.debug('Created canya locally', entry);
      return entry;
    } catch (e, stack) {
      loggy.error('Error inserting locally', e);
      rethrow;
    }
  }
}
