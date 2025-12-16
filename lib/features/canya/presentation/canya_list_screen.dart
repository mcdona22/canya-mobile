import 'package:canya/util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class CanyaListScreen extends HookConsumerWidget
    with UiLoggy {
  const CanyaListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: createAppBar(context, 'CanYa List'),
    );
  }
}
