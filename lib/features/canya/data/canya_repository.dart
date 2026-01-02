import 'dart:async';

import 'package:canya/common/data/local_database_provider.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';

import 'canya_event.dart';

part 'canya_repository.g.dart';

typedef JsonList = List<Map<String, dynamic>>;

@Riverpod()
CanyaRepository canyaRepository(Ref ref) => CanyaRepository(
  // client: ref.watch(supabaseClientProvider),
  localDatabase: ref.watch(localDatabaseProvider),
);

class CanyaRepository with UiLoggy {
  final tableName = 'canya_event';
  final withSlotsView = 'canya_event_with_slots';
  final _canyaStreamController =
      StreamController<List<CanyaEvent>>.broadcast();

  CanyaRepository({
    // required this.client,
    required this.localDatabase,
  });

  // final SupabaseClient client;
  final Database localDatabase;

  Stream<List<CanyaEvent>> fetchAll() {
    _refreshCanyaList();
    return _canyaStreamController.stream;
    // final response = client
    //     .from(tableName)
    //     .stream(primaryKey: ['id'])
    //     .order('name', ascending: true)
    //     .map(
    //       (data) => data
    //           .map((json) => CanyaEvent.fromMap(json))
    //           .toList(),
    //     );
    //
    // return response;
  }

  Future<void> _refreshCanyaList() async {
    try {
      final List<Map<String, dynamic>> rows =
          await localDatabase.query(
            tableName,
            orderBy: 'name COLLATE NOCASE ASC',
          );
      final list = rows
          .map((json) => CanyaEvent.fromMap(json))
          .toList();
      _canyaStreamController.add(list);
    } catch (e) {
      loggy.error(
        "Failed to refresh canya list",
        e.toString(),
      );
    }
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
      _refreshCanyaList();
      return entry;
    } catch (e, stack) {
      loggy.error('Error inserting locally', e);
      rethrow;
    }
  }

  Stream<CanyaEvent> fetchById(String id) {
    return fetchAll().map((list) {
      return list.firstWhere(
        (e) => e.id == id,
        orElse: () =>
            throw Exception('Event $id not found'),
      );
    });
  }
}
