import 'package:canya/common/data/supabase_provider.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

part 'canya_repository.g.dart';

@Riverpod()
CanyaRepository canyaRepository(ref) => CanyaRepository(
  client: ref.watch(supabaseClientProvider),
);

class CanyaRepository with UiLoggy {
  final tableName = 'canya_event';

  CanyaRepository({required this.client});

  final SupabaseClient client;

  Future<List<Map<String, dynamic>>> fetchAll() {
    return client.from(tableName).select();
  }
}
