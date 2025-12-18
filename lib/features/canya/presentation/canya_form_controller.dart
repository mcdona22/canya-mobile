import 'package:flutter/cupertino.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'canya_form_controller.g.dart';

@riverpod
class CanyaFormController extends _$CanyaFormController
    with UiLoggy {
  CanyaFormController();

  final nameTextController = TextEditingController();
  final descTextController = TextEditingController();

  @override
  FutureOr<void> build() {
    ref.onDispose(_dispose);
  }

  void onSubmit() async {
    try {
      state = AsyncLoading();
      loggy.info('Name: ${nameTextController.value}');
      loggy.info('Desc: ${descTextController.value}');
    } catch (error) {
      loggy.error('Hmm');
      rethrow;
    } finally {
      await Future.delayed(const Duration(seconds: 2));
      state = AsyncData(null);
    }
  }

  void _dispose() {
    nameTextController.dispose();
    descTextController.dispose();
    loggy.debug('TextEditingControllers disposed.');
  }
}
