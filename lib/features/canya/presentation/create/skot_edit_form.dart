import 'package:canya/common/dimensions.dart';
import 'package:canya/common/presentation/async_value_widget.dart';
import 'package:canya/common/presentation/form_items.dart';
import 'package:canya/features/canya/presentation/create/slot_form_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

class SlotForm extends HookConsumerWidget with UiLoggy {
  const SlotForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(slotFormControllerProvider);
    final controller = ref.watch(
      slotFormControllerProvider.notifier,
    );

    final formKey = useMemoized(
      () => GlobalKey<FormState>(),
    );
    final whenTime = useState<DateTime?>(null);
    final whenDate = useState<DateTime?>(null);

    return Form(
      key: formKey,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              spacing: kListSpacingMedium,
              children: [
                Row(
                  spacing: kListSpacingMedium,
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller
                            .whenDateTextController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Date',
                          hint: Text('Enter the date'),
                          border: textInputBorder,
                          prefixIcon: IconButton(
                            onPressed: () => controller
                                .onPickDate(context),

                            icon: Icon(
                              Icons.calendar_month,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextFormField(
                        controller: controller
                            .whenTimeTextController,
                        readOnly: true,
                        decoration: InputDecoration(
                          labelText: 'Time',
                          hint: Text('time, if needed'),
                          border: textInputBorder,
                          prefixIcon: IconButton(
                            onPressed: () => controller
                                .onPickTime(context),
                            icon: Icon(Icons.watch),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller
                            .commentTextController,
                        decoration: InputDecoration(
                          labelText: 'Comment',
                          hint: Text('only if needed'),
                          border: textInputBorder,
                        ),
                      ),
                    ),

                    AsyncValueWidget(
                      value: ref.watch(
                        slotFormControllerProvider,
                      ),
                      data: (valid) => SizedBox(
                        width: 50.0,
                        child: IconButton(
                          icon: Icon(Icons.save),
                          onPressed: valid
                              ? () {
                                  final slot = controller
                                      .submit();
                                  loggy.debug(
                                    'Created this slot : $slot',
                                  );
                                  Navigator.of(
                                    context,
                                  ).pop(slot);
                                }
                              : null,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onSubmit(
    ValueNotifier<DateTime?> d,
    ValueNotifier<DateTime?> t,
    TextEditingController comments,
  ) {
    loggy.debug(
      'The state is {date: ${d.value}, time: ${t.value ?? "null"} '
      'comment: ${comments.text}}',
    );

    d.value = null;
    t.value = null;
    comments.text = '';
  }
}
