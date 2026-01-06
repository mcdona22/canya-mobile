import 'dart:async';

import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../common/data/supabase_provider.dart';
import 'canya_event.dart';

part 'canya_repository.g.dart';

typedef JsonList = List<Map<String, dynamic>>;

@Riverpod()
CanyaRepository canyaRepository(Ref ref) => CanyaRepository(
  client: ref.watch(supabaseClientProvider),
);

class CanyaRepository with UiLoggy {
  final tableName = 'canya_event';
  final withSlotsView = 'canya_event_with_slots';

  CanyaRepository({required this.client});

  final SupabaseClient client;

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
        .from(tableName)
        .stream(primaryKey: ['id'])
        .eq('id', id)
        .map((data) {
          if (data.isEmpty) {
            throw Exception('No Canya with an id of $id');
          }
          return CanyaEvent.fromMap(data.first);
        });

    return response;
  }

  Future<void> createCanya(CanyaEvent c) async {
    try {
      final response = await client
          .from(tableName)
          .insert(c.toTableMap()..remove('id'))
          .select();

      loggy.debug('insert response', response);
      final canyaId = response[0]['id'];
      loggy.debug('ID is $canyaId');
    } catch (e, _) {
      loggy.error('Error inserting', e);
      rethrow;
    }
  }
}
