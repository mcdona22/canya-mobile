import 'package:canya/common/data/supabase_provider.dart';
import 'package:canya/features/canya/data/canya_repository.dart';
import 'package:canya/util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class CanyaSummaryScreen extends HookConsumerWidget
    with UiLoggy {
  const CanyaSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final client = ref.watch(supabaseClientProvider);
    // final future = client.from('canya_event').select();
    final repository = ref.watch(canyaRepositoryProvider);

    repository.fetchAll().then(
      (data) => loggy.debug('All Canyas', data),
    );

    // future.then((data) => loggy.debug('Data', data));

    return Scaffold(
      appBar: createAppBar(context, 'CanYa Summary'),
    );
  }
}
