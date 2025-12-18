import 'package:canya/common/routing/router.dart';
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
    // final client = ref.watch(supabaseClientProvider);
    // final future = client.from('canya_event').select();
    // // final repository = ref.watch(canyaRepositoryProvider);
    // //
    // future.then((data) => loggy.debug('All Canyas', data));
    final accentColor = Theme.of(
      context,
    ).colorScheme.secondaryFixed;
    final asyncValue = ref.watch(fetchAllCanyasProvider);

    // future.then((data) => loggy.debug('Data', data));

    return Scaffold(
      appBar: createAppBar(context, 'CanYa Summary'),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18.0,
        ),
        child: asyncValue.when(
          data: (data) => ListView.builder(
            itemBuilder: (_, i) => Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
              ),
              child: ListTile(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(color: accentColor),
                ),
                leading: Icon(
                  Icons.calendar_month,
                  color: Colors.orange,
                  size: 38.0,
                ),
                title: Text(data[i].name),
                subtitle: Column(
                  crossAxisAlignment:
                      CrossAxisAlignment.start,
                  children: [
                    Text(data[i].description ?? ''),
                    Text(data[i].id ?? ''),
                  ],
                ),
              ),
            ),
            itemCount: data.length,
          ),
          loading: () => CircularProgressIndicator(),
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
