import 'package:flutter/material.dart';

PreferredSizeWidget createAppBar(
  BuildContext context,
  String title,
) {
  return AppBar(
    title: Text(title),
    toolbarHeight: 120.0,
    // elevation: 1.0,
    // primary: true,
    // backgroundColor: Theme.of(
    //   context,
    // ).colorScheme.inversePrimary,
  );
}
