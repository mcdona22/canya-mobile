import 'package:canya/features/auth/presentation/sign_in_screen.dart';
import 'package:canya/features/canya/presentation/canya_list_screen.dart';
import 'package:canya/features/landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute { signIn, home, canyaList }

final routerConfig = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.home.name,
      pageBuilder: (_, state) => MaterialPage(
        child: LandingScreen(),
        key: state.pageKey,
        fullscreenDialog: true,
      ),
    ),

    GoRoute(
      path: '/signIn',
      name: AppRoute.signIn.name,
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        fullscreenDialog: true,
        child: SignInScreen(),
      ),
    ),

    GoRoute(
      path: '/canya',
      name: AppRoute.canyaList.name,
      pageBuilder: (_, state) => MaterialPage(
        child: CanyaListScreen(),
        key: state.pageKey,
        fullscreenDialog: true,
      ),
    ),
  ],
);
