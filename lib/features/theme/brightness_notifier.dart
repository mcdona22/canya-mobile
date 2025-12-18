import 'package:flutter/material.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'brightness_notifier.g.dart';

@Riverpod(keepAlive: true)
Future<SharedPreferences> sharedPreferences(_) async {
  return await SharedPreferences.getInstance();
}

@Riverpod(keepAlive: true)
class BrightnessNotifier extends _$BrightnessNotifier
    with UiLoggy {
  final _themeKey = 'com.mcdona22.canya.theme';
  SharedPreferences? _preferences;
  ThemeMode _themeMode = ThemeMode.light;

  @override
  FutureOr<ThemeMode> build() async {
    loggy.debug('Fetching preferences');
    _preferences = await ref.watch(
      sharedPreferencesProvider.future,
    );
    final index =
        _preferences?.getInt(_themeKey) ?? _themeMode.index;
    _themeMode = ThemeMode.values[index];
    return _themeMode;
  }

  void toggleTheme() {
    loggy.debug('Toggling theme');
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;

    state = AsyncData(_themeMode);
    _preferences?.setInt(_themeKey, _themeMode.index);
  }
}
