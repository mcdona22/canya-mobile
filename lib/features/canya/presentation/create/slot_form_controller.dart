import 'package:canya/common/presentation/dates_util.dart';
import 'package:canya/features/canya/data/slot.dart'
    show Slot;
import 'package:canya/util.dart';
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
  FutureOr<bool> build() {
    return _isValid();
  }

  bool _isValid() => whenDate != null;

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

    state = AsyncValue.data(_isValid());
  }

  Future<void> onPickTime(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
    );

    loggy.debug('onPickTime', time);

    if (time != null) {
      loggy.info('appending the time');
      whenTime = DateTime(0, 1, 1, time.hour, time.minute);
      loggy.info('Result', whenTime);
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

    if (whenTime != null) {
      whenDate = DateTime(
        whenDate!.year,
        whenDate!.month,
        whenDate!.day,
        whenTime!.hour,
        whenTime!.minute,
        0,
        0,
        0,
      );
    }

    final slot = Slot(
      id: createUuid(),
      comments: commentTextController.text ?? '',
      when: whenDate!,
    );
    _reset();
    state = AsyncValue.data(_isValid());
    return slot;
  }

  _reset() {
    whenDate = whenTime = null;
    whenDateTextController.text =
        whenTimeTextController.text =
            commentTextController.text = '';
  }
}
