import 'package:canya/common/routing/router.dart';
import 'package:canya/features/theme/brightness_notifier.dart';
import 'package:canya/features/theme/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_loggy/flutter_loggy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import 'features/canya/data/canya.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  Loggy.initLoggy(
    logPrinter: const PrettyDeveloperPrinter(),
  );

  final container = ProviderContainer();
  await container.read(brightnessProvider.future);

  final canya = Canya(
    name: 'JRM',
    ownerId: 'jrm',
    description: 'This is my description',
  );

  logInfo('Canya Created', canya);
  logInfo('Canya JSON', canya.toJson());

  runApp(
    UncontrolledProviderScope(
      container: container,
      child: App(),
    ),
  );
  logInfo('App up and running');
}

class App extends HookConsumerWidget with UiLoggy {
  const App({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightnessAsyncValue = ref.watch(
      brightnessProvider,
    );
    return brightnessAsyncValue.when(
      loading: () => const ScaffoldedWidget(
        child: CircularProgressIndicator(),
      ),
      error: (error, stack) =>
          ScaffoldedWidget(child: Text(error.toString())),
      data: (themeMode) {
        loggy.info('We now have some preferences data');
        return MaterialApp.router(
          routerConfig: routerConfig,
          theme: ThemeData.from(
            colorScheme: lightColorScheme,
          ),
          darkTheme: ThemeData.from(
            colorScheme: darkColorScheme,
            useMaterial3: true,
          ),
          themeMode: themeMode,
          themeAnimationDuration: Duration(
            milliseconds: 750,
          ),
        );
      },
    );
  }
}

class ScaffoldedWidget extends HookConsumerWidget
    with UiLoggy {
  final Widget child;

  const ScaffoldedWidget({required this.child, super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
