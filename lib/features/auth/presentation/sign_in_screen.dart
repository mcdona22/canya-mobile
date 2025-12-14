import 'package:canya/util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import '../../../common/routing/router.dart';

class SignInScreen extends HookConsumerWidget with UiLoggy {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    loggy.debug('Sign In Screen presented');
    return Scaffold(
      appBar: createAppBar(context, 'Sign In'),
      body: Center(
        child: ElevatedButton(
          onPressed: () =>
              context.goNamed(AppRoute.home.name),
          child: Text('Home'),
        ),
      ),
    );
  }
}
