import 'package:canya/util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import '../data/canya.dart';

class CanyaListScreen extends HookConsumerWidget
    with UiLoggy {
  const CanyaListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final canya = Canya(
      name: 'Johns Canya',
      ownerId: 'jrm',
      description: 'my canya',
      id:
          'sswwe4'
          '3ddFgde2hdJJ',
    );
    return Scaffold(
      appBar: createAppBar(context, 'CanYa List'),
      body: Center(child: Text('$canya')),
    );
  }
}
