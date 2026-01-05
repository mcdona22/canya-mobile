import 'package:canya/features/auth/presentation/sign_in_screen.dart';
import 'package:canya/features/canya/presentation/canya_detail_screen.dart';
import 'package:canya/features/canya/presentation/canya_new_screen.dart';
import 'package:canya/features/canya/presentation/canya_summary_screen.dart';
import 'package:canya/features/landing/landing_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

enum AppRoute {
  signIn,
  home,
  canya,
  canyaNew,
  canyaEdit,
  canyaDetail,
}

final routerConfig = GoRouter(
  initialLocation: '/canya/new',
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
      name: AppRoute.canya.name,
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        fullscreenDialog: true,
        child: CanyaSummaryScreen(),
      ),
    ),
    GoRoute(
      path: '/canya/new',
      name: AppRoute.canyaNew.name,
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        fullscreenDialog: true,
        child: CanyaNewScreen(),
      ),
    ),

    GoRoute(
      path: '/canya/:id',
      name: AppRoute.canyaDetail.name,
      pageBuilder: (_, state) => MaterialPage(
        key: state.pageKey,
        fullscreenDialog: true,
        child: CanyaDetailScreen(
          id: state.pathParameters['id']!,
        ),
      ),
    ),
  ],
);
