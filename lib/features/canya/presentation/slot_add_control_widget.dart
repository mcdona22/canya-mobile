import 'package:canya/common/dimensions.dart';
import 'package:canya/features/canya/presentation/create/slot_edit_form.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import '../data/slot.dart';

class SlotAddControlWidget extends HookConsumerWidget
    with UiLoggy {
  final void Function(Slot) onCreateSlot;

  const SlotAddControlWidget({
    required this.onCreateSlot,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () => _onSlotAdd(context),
      child: Text('Add Slot'),
    );
  }

  Future<void> _onSlotAdd(BuildContext context) async {
    final slot = await showModalBottomSheet<Slot>(
      context: context,
      elevation: 3.0,
      builder: (context) => SizedBox(
        height: 300.0,
        child: Column(
          spacing: kListSpacingMedium,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create a Slot',
              style: Theme.of(
                context,
              ).textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.all(kPaddingMedium),
              child: SlotForm(),
            ),
          ],
        ),
      ),
    );

    loggy.debug('return val', slot);
    slot != null
        ? onCreateSlot(slot)
        : loggy.debug('Cancelled');
  }
}
