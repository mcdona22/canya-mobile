import 'package:canya/features/canya/presentation/slot_tile.dart';
import 'package:flutter/material.dart';

import '../data/slot.dart';

class CanyaSlotList extends StatelessWidget {
  const CanyaSlotList({required this.slots, super.key});

  final List<Slot> slots;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (slots.isNotEmpty)
          ...List.generate(
            slots.length,
            (i) => SlotTile(slot: slots[i]),
          ),
      ],
    );
  }
}
