import 'package:canya/common/presentation/dates_util.dart';
import 'package:canya/features/canya/data/slot.dart'
    show Slot;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
    show showDatePicker, showTimePicker, TimeOfDay;
import 'package:loggy/loggy.dart';
import 'package:riverpod_annotation/riverpod_annotation'
    '.dart';

part 'slot_form_controller.g.dart';

@riverpod
class SlotFormController extends _$SlotFormController
    with UiLoggy {
  SlotFormController() {}

  DateTime? whenDate;
  DateTime? whenTime;
  final whenDateTextController = TextEditingController();
  final whenTimeTextController = TextEditingController();
  final commentTextController = TextEditingController();

  void reset() {
    whenDate = whenTime = null;
    whenTimeTextController.text = '';
    whenDateTextController.text = '';
    commentTextController.text = '';
  }

  @override
  FutureOr<void> build() {}

  Future<void> onPickDate(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365 * 2)),
    );

    if (date != null) {
      loggy.debug('Selected date: ', whenDate);
      whenDate = date;
      whenDateTextController.text = dateOnlyFormatter
          .format(whenDate!);
    }
  }

  Future<void> onPickTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
    );

    if (time != null) {
      whenTime = DateTime(0, 1, 1, time.hour, time.minute);
      whenTimeTextController.text = timeOnlyFormatter
          .format(whenTime!);
    }
  }

  Slot submit() {
    state = AsyncValue.loading();
    loggy.debug(
      'The state is : {whenDate: $whenDate, '
      'whenTime: $whenTime, comment: '
      '${commentTextController.text}',
    );

    final slot = Slot(
      comments: commentTextController.text ?? '',
      when: whenDate!,
    );
    _reset();
    state = AsyncValue.data(null);
    return slot;
  }

  _reset() {
    whenDate = whenTime = null;
    whenDateTextController.text =
        whenTimeTextController.text =
            commentTextController.text = '';
  }
}
