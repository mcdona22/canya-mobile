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
    return Scaffold(
      appBar: createAppBar(context, 'CanYa Detail'),
      body: Center(
        child: Text('Under  Construction:  : $id'),
      ),
    );
  }
}
