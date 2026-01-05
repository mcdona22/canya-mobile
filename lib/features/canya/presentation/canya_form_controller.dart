import 'package:canya/common/presentation/form_items.dart';
import 'package:canya/features/canya/data/canya_event.dart';
import 'package:canya/features/canya/service/canya_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/slot.dart';

part 'canya_form_controller.g.dart';

@riverpod
class CanyaFormController extends _$CanyaFormController
    with UiLoggy {
  CanyaFormController();

  late CanyaService canyaService;
  final nameTextController = TextEditingController();
  final descTextController = TextEditingController();
  final List<Slot> _slots = [
    Slot(comments: 'New slot by JRM', when: DateTime.now()),
  ];

  List<Slot> get currentSlots => List.unmodifiable(_slots);

  void addSlot(Slot slot) {
    loggy.debug('Adding slot to list', slot);
    _slots.add(slot);
    ref.notifyListeners();
  }

  @override
  FutureOr<void> build() {
    canyaService = ref.watch(canyaServiceProvider);
    ref.onDispose(_dispose);
  }

  void onSubmit(
    ControllerOutcomeCallBack onSuccess,
    ControllerOutcomeCallBack onError,
  ) async {
    try {
      state = AsyncLoading();
      final ce = CanyaEvent(
        name: nameTextController.text,
        description: descTextController.text,
        slots: [],
      );
      await canyaService.addCanya(ce);
      // loggy.debug('Created', ce.toMap());
      onSuccess(
        'The Canya for "${ce.name}" has been created',
      );
    } catch (error) {
      loggy.error('Hmm');
      onError("something went wrong $error");
      rethrow;
    } finally {
      // await Future.delayed(const Duration(seconds: 2));
      state = AsyncData(null);
    }
  }

  void _dispose() {
    nameTextController.dispose();
    descTextController.dispose();
    loggy.debug('TextEditingControllers disposed.');
  }
}
