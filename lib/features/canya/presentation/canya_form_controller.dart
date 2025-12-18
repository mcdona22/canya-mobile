import 'package:canya/features/canya/data/canya_event.dart';
import 'package:canya/features/canya/service/canya_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'canya_form_controller.g.dart';

@riverpod
class CanyaFormController extends _$CanyaFormController
    with UiLoggy {
  CanyaFormController();

  late CanyaService canyaService;
  final nameTextController = TextEditingController();
  final descTextController = TextEditingController();

  @override
  FutureOr<void> build() {
    canyaService = ref.watch(canyaServiceProvider);
    ref.onDispose(_dispose);
  }

  void onSubmit() async {
    try {
      state = AsyncLoading();
      loggy.info('Name: ${nameTextController.text}');
      loggy.info('Desc: ${descTextController.text}');
      final ce = CanyaEvent(
        name: nameTextController.text,
        description: descTextController.text,
      );
      await canyaService.addCanya(ce);
      loggy.debug('Created', ce.toMap());
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
