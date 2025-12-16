import 'package:canya/common/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:loggy/loggy.dart';

import 'features/theme/theme_toggle_button.dart';

PreferredSizeWidget createAppBar(
  BuildContext context,
  String title,
) {
  return AppBar(
    title: Text(title),
    toolbarHeight: 120.0,
    elevation: 1.0,
    // primary: true,
    // backgroundColor: Theme.of(
    //   context,
    // ).colorScheme.inversePrimary,
    actions: const [ThemeToggleButton(), HomeIconButton()],
  );
}

class HomeIconButton extends StatelessWidget with UiLoggy {
  const HomeIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.goNamed(AppRoute.home.name),
      icon: Icon(Icons.home),
    );
  }
}
