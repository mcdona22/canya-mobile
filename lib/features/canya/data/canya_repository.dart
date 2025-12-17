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
}

@Riverpod()
Stream<List<CanyaEvent>> fetchAllCanyas(Ref ref) =>
    ref.watch(canyaRepositoryProvider).fetchAll();
