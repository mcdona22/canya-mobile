import 'package:canya/common/dimensions.dart';
import 'package:canya/common/presentation/async_value_widget.dart';
import 'package:canya/common/presentation/centred_constrained_widget.dart';
import 'package:canya/features/canya/data/canya_event.dart';
import 'package:canya/features/canya/service/canya_service.dart';
import 'package:canya/util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';

import '../data/slot.dart';

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
          data: (c) => CanyaDetailView(canya: c),
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

    return CentredConstrainedWidget(
      child: Column(
        children: [
          SizedBox(
            height: 180.0,
            child: Card(
              child: SizedBox(
                width: double.infinity,

                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment:
                        MainAxisAlignment.start,
                    crossAxisAlignment:
                        CrossAxisAlignment.center,
                    spacing: kListSpacingMedium,
                    children: [
                      Text(
                        canya.name,
                        style: theme.textTheme.displayMedium
                            ?.copyWith(letterSpacing: 3.0),
                        textAlign: TextAlign.center,
                      ),
                      if (canya.description != null)
                        Expanded(
                          child: Text(
                            canya.description!,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      // Divider(endIndent: 20.0, indent: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Text(
          //   'Available Slots',
          //   style: theme.textTheme.headlineMedium,
          // ),

          // if (canya.slots.isEmpty)
          //   Text(
          //     'The creator of this event has yet to '
          //     'publish some slots',
          //   ),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if (canya.slots.isEmpty)
                    Text(
                      'The creator of this event has yet to '
                      'publish some slots',
                      textAlign: TextAlign.center,
                    ),
                  // if (canya.slots.isNotEmpty)
                  //   ...List.generate(
                  //     canya.slots.length,
                  //     (i) => SlotTile(slot: canya.slots[i]),
                  //   ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SlotTile extends HookConsumerWidget with UiLoggy {
  final Slot slot;

  const SlotTile({required this.slot, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = 'dd-MMM-yy @ kk:mm';
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      spacing: 10.0,
      children: [
        Text('${DateFormat(dateFormat).format(slot.when)}'),
        if (slot.comments.isNotEmpty)
          // TODO either add a tooltip, make it
          //  responsive to mobiles or both
          Expanded(
            child: Text(
              slot.comments,
              overflow: TextOverflow.ellipsis,
            ),
          ),
      ],
    );
  }
}
