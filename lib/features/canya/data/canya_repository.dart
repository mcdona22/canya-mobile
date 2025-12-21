import 'package:canya/common/data/supabase_provider.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    try {
      final data = c.toTableMap();
      loggy.info('The map being passed is : ', data);
      final response = await client
          .from(tableName)
          .upsert(data)
          .select()
          .single();
      final canya = CanyaEvent.fromMap(response);
      loggy.debug('Created canya', canya);
      return canya;
    } catch (e, stack) {
      loggy.error('Error inserting', e);
      rethrow;
    }
  }
}
