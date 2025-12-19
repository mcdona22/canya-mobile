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

  Future<CanyaEvent> addCanya(CanyaEvent canya) async {
    return await canyaRepository.createCanya(canya);
  }
}

@Riverpod()
Stream<List<CanyaEvent>> fetchAllCanyas(Ref ref) =>
    ref.watch(canyaRepositoryProvider).fetchAll();

@Riverpod()
Stream<CanyaEvent> watchCanya(Ref ref, String id) =>
    ref.watch(canyaRepositoryProvider).fetchById(id);
