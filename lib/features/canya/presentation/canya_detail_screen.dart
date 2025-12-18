import 'package:canya/common/dimensions.dart';
import 'package:canya/common/presentation/async_value_widget.dart';
import 'package:canya/features/canya/data/canya_event.dart';
import 'package:canya/features/canya/service/canya_service.dart';
import 'package:canya/util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class CanyaDetailScreen extends HookConsumerWidget
    with UiLoggy {
  final String id;

  const CanyaDetailScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canya = ref.watch(watchCanyaProvider(id));
    return Scaffold(
      appBar: createAppBar(context, 'CanYa Detail'),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(kPaddingMedium),
        child: AsyncValueWidget<CanyaEvent>(
          value: canya,
          // data: (c) => CanyaDetailView(canya: c),
          data: (c) => SingleChildScrollView(
            child: Column(
              children: [
                // Text(c.name),
                CanyaDetailView(canya: c),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CanyaDetailView extends HookConsumerWidget
    with UiLoggy {
  const CanyaDetailView({required this.canya, super.key});

  final CanyaEvent canya;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Card(
      child: SizedBox(
        width: double.infinity,

        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: kListSpacingMedium,
            children: [
              Text(
                canya.name,
                style: theme.textTheme.displayMedium
                    ?.copyWith(letterSpacing: 3.0),
                textAlign: TextAlign.center,
              ),
              if (canya.description != null)
                Text(canya.description!),
              // Divider(endIndent: 20.0, indent: 20.0),
            ],
          ),
        ),
      ),
    );
  }
}
