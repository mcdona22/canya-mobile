import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class SocialMediaButton extends HookConsumerWidget
    with UiLoggy {
  final String? imagePath;

  final String label;
  final void Function()? onPressed;

  const SocialMediaButton({
    this.imagePath,
    required this.label,
    this.onPressed,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final content = Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        if (imagePath != null)
          SizedBox.square(
            dimension: 30.0,
            child: Image.asset(
              imagePath!,
              fit: BoxFit.cover,
            ),
          ),
        Text(label),
        Opacity(
          opacity: 0.0,
          child: SizedBox.square(
            dimension: 30.0,
            child: Image.asset(
              imagePath!,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ],
    );

    return ElevatedButton(
      onPressed: onPressed,
      child: content,
    );
  }
}
