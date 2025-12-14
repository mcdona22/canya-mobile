import 'package:canya/common/routing/router.dart';
import 'package:canya/util.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class LandingScreen extends HookConsumerWidget
    with UiLoggy {
  const LandingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: createAppBar(context, 'Welcome to CanYa'),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(12.0),
          width: double.infinity,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 40.0,
            children: [
              OutlinedButton(
                onPressed: () =>
                    context.goNamed(AppRoute.signIn.name),
                child: Text('Show Auth Screen'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
