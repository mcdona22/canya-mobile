import 'package:canya/common/routing/router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/theme/theme_toggle_button.dart';

PreferredSizeWidget createAppBar(
  BuildContext context,
  String title,
) {
  return AppBar(
    title: Text(
      title,
      style: Theme.of(context).textTheme.titleLarge,
    ),
    toolbarHeight: 120.0,
    centerTitle: true,
    // elevation: 1.0,
    // primary: true,
    // backgroundColor: Theme.of(
    //   context,
    // ).colorScheme.inversePrimary,
    actions: [ThemeToggleButton(), HomeActionButton()],
  );
}

class HomeActionButton extends StatelessWidget {
  const HomeActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.goNamed(AppRoute.home.name),
      icon: Icon(Icons.home),
    );
  }
}
