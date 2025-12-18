import 'package:canya/features/canya/data/canya_event.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/canya_repository.dart';

part 'canya_service.g.dart';

@riverpod
CanyaService canyaService(Ref ref) {
  // ref.onDispose(() => logDebug('disposing CanyaService'));

  return CanyaService(
    canyaRepository: ref.watch(canyaRepositoryProvider),
  );
}

class CanyaService with UiLoggy {
  final CanyaRepository canyaRepository;

  CanyaService({required this.canyaRepository});

  Future<void> addCanya(CanyaEvent canya) async {
    return await canyaRepository.createCanya(canya);
  }
}
// @riverpod
// class CanyaService extends _$CanyaService with UiLoggy {
//   final tableName = 'canya_event';
//
//   late SupabaseClient client;
//
//   @override
//   FutureOr<void> build() async {
//     client = ref.watch(supabaseClientProvider);
//
//     ref.onDispose(
//       () => loggy.info('Canya Service being destroyed'),
//     );
//     return;
//   }
//
//   Future<void> addCanya({
//     required String name,
//     String description = '',
//   }) async {
//     final canya = CanyaEvent(
//       name: name,
//       description: description,
//     );
//
//     try {
//       await client.from(tableName).insert(canya.toMap());
//     } catch (e, stack) {
//       loggy.error('There has been a problem', e);
//       rethrow;
//     }
//   }
// }

@Riverpod()
Stream<List<CanyaEvent>> fetchAllCanyas(Ref ref) =>
    ref.watch(canyaRepositoryProvider).fetchAll();
