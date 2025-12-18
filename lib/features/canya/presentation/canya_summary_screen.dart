import 'package:canya/common/routing/router.dart';
import 'package:canya/features/canya/data/canya_event.dart';
import 'package:canya/features/canya/service/canya_service.dart';
import 'package:canya/util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class CanyaSummaryScreen extends HookConsumerWidget
    with UiLoggy {
  const CanyaSummaryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncValue = ref.watch(fetchAllCanyasProvider);

    // future.then((data) => loggy.debug('Data', data));
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: createAppBar(context, 'CanYa Summary'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
        ),
        child: asyncValue.when(
          data: (data) => data.isEmpty
              ? Center(
                  child: Text(
                    'There are no CanYas at the moment - '
                    'create one?',
                    textAlign: TextAlign.center,
                    style: textTheme.titleLarge,
                  ),
                )
              : ListView.builder(
                  itemBuilder: (_, i) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ),
                    child: CanyaSummaryTile(canya: data[i]),
                  ),
                  itemCount: data.length,
                ),
          loading: () =>
              Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('$err'),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            context.goNamed(AppRoute.canyaNew.name),
        // onPressed: () {
        //   final faker = Faker();
        //   ref
        //       .read(canyaServiceProvider.notifier)
        //       .addCanya(
        //         name: faker.company.name(),
        //         description: faker.company.person.name(),
        //       );
        // },
        child: Icon(Icons.add),
      ),
    );
  }
}

class CanyaSummaryTile extends HookConsumerWidget
    with UiLoggy {
  const CanyaSummaryTile({required this.canya, super.key});

  final CanyaEvent canya;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final color = Theme.of(context).colorScheme.primary;
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: color),
      ),
      leading: Icon(
        Icons.calendar_month,
        color: color,
        size: 38.0,
      ),
      trailing: TextButton(
        onPressed: () =>
            _navigateToDetail(context, canya.id!),
        child: Text('View'),
      ),

      title: Text(canya.name),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Text(canya.description ?? '')],
      ),
    );
  }

  void _navigateToDetail(BuildContext context, String id) {
    loggy.info('Lets go', id);
    context.goNamed(
      AppRoute.canyaDetail.name,
      pathParameters: {'id': id},
    );
  }
}
