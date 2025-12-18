import 'package:canya/common/data/supabase_provider.dart';
import 'package:canya/features/canya/data/canya_event.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../data/canya_repository.dart';

part 'canya_service.g.dart';

@riverpod
class CanyaService extends _$CanyaService with UiLoggy {
  final tableName = 'canya_event';

  late SupabaseClient client;

  @override
  FutureOr<void> build() async {
    client = ref.watch(supabaseClientProvider);

    ref.onDispose(
      () => loggy.info('Canya Service being destroyed'),
    );
    return;
  }

  Future<void> addCanya({
    required String name,
    String description = '',
  }) async {
    final canya = CanyaEvent(
      name: name,
      description: description,
    );

    try {
      await client.from(tableName).insert(canya.toMap());
    } catch (e, stack) {
      loggy.error('There has been a problem', e);
      rethrow;
    }
  }
}

@Riverpod()
Stream<List<CanyaEvent>> fetchAllCanyas(Ref ref) =>
    ref.watch(canyaRepositoryProvider).fetchAll();
