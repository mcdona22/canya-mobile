import 'package:canya/util.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class CanyaNewScreen extends HookConsumerWidget
    with UiLoggy {
  const CanyaNewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: createAppBar(context, 'New CanYa'),
    );
  }
}
