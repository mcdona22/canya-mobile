import 'package:canya/common/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:loggy/loggy.dart';

import '../data/slot.dart';

class SlotTile extends HookConsumerWidget with UiLoggy {
  final Slot slot;

  const SlotTile({required this.slot, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateFormat = 'dd-MMM-yy';
    final timeFormat = 'kk:mm';
    return Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      spacing: kListSpacingLarge,
      children: [
        if (_isOwner())
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => loggy.info('edit ${slot.id}'),
          ),
        Text(DateFormat(dateFormat).format(slot.when)),
        if (slot.comments.isNotEmpty)
          Expanded(
            child: Text(
              slot.comments,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        if (!_isDefaultTime(slot.when))
          Text(DateFormat(timeFormat).format(slot.when)),
      ],
    );
  }

  bool _isDefaultTime(DateTime dt) =>
      dt.hour == 0 && dt.minute == 0;

  bool _isOwner() => true;
}
