import 'package:canya/features/theme/brightness_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class ThemeToggleButton extends HookConsumerWidget
    with UiLoggy {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref
        .watch(brightnessProvider)
        .asData!
        .value;
    return IconButton(
      onPressed: () {
        loggy.debug('Toggle Theme');
        ref.read(brightnessProvider.notifier).toggleTheme();
      },
      icon: Icon(
        currentTheme == ThemeMode.dark
            ? Icons.light_mode
            : Icons.dark_mode,
      ),
    );
  }
}
