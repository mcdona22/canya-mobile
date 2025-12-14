import 'package:canya/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  signIn,
  home
}

final routerConfig  = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/', name: AppRoute.home.name,
      pageBuilder: (_, state) =>
          MaterialPage(child: MyHomePage(title: "CanYa"), key: state.pageKey,
              fullscreenDialog: true)
    )
  ]
);