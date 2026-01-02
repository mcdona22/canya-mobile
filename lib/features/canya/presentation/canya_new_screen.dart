import 'package:canya/common/dimensions.dart';
import 'package:canya/common/presentation/centred_constrained_widget.dart';
import 'package:canya/common/presentation/form_items.dart';
import 'package:canya/common/routing/router.dart';
import 'package:canya/features/canya/presentation/canya_form_controller.dart';
import 'package:canya/util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:form_validator/form_validator.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:loggy/loggy.dart';

import 'canya_detail_screen.dart';
import 'create/skot_edit_form.dart';

class CanyaNewScreen extends HookConsumerWidget
    with UiLoggy {
  const CanyaNewScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: createAppBar(context, 'New CanYa'),
      // resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: CentredConstrainedWidget(
          child: Padding(
            padding: const EdgeInsets.all(kPaddingSmall),
            child: CanyaEventForm(),
          ),
        ),
      ),
    );
  }
}

class CanyaEventForm extends HookConsumerWidget
    with UiLoggy {
  const CanyaEventForm({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(canyaFormControllerProvider);
    final controller = ref.watch(
      canyaFormControllerProvider.notifier,
    );
    final formKey = useMemoized(
      () => GlobalKey<FormState>(),
    );
    return Form(
      key: formKey,
      child: Column(
        spacing: kListSpacingMedium,
        children: [
          TextFormField(
            controller: controller.nameTextController,
            validator: ValidationBuilder()
                .minLength(4)
                .maxLength(20)
                .build(),
            decoration: InputDecoration(
              labelText: 'Name',
              border: textInputBorder,
            ),
          ),

          TextFormField(
            controller: controller.descTextController,
            // validator: ValidationBuilder()
            //     .maxLength(20)
            //     .build(),
            decoration: InputDecoration(
              labelText: 'Description',
              border: textInputBorder,
            ),
            maxLines: 8,
            minLines: 4,
            maxLength: 100,
          ),

          state.isLoading
              ? CircularProgressIndicator()
              : ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      controller.onSubmit(
                        ((message) => _onSuccess(
                          context,
                          message ?? '',
                        )),
                        ((message) => _onFailure(
                          context,
                          message ?? '',
                        )),
                      );
                    } else {
                      loggy.debug('invalid');
                    }
                  },
                  child: Text('Save Canya'),
                ),

          if (controller.currentSlots.isEmpty)
            Text('Add some slots for your event'),
          // SlotForm(),
          TextButton(
            onPressed: () {
              loggy.info('click');
              _onSlotAdd(context);
            },
            child: Text('add slot'),
          ),
          if (controller.currentSlots.isNotEmpty)
            ...List.generate(
              controller.currentSlots.length,
              (i) => SlotTile(
                slot: controller.currentSlots[i],
              ),
            ),
        ],
      ),
    );
  }

  void _onSuccess(BuildContext context, String msg) {
    loggy.debug(msg);
    context.goNamed(AppRoute.canya.name);
  }

  void _onFailure(BuildContext context, String msg) {
    loggy.debug(msg);
    // context.goNamed(AppRoute.canya.name);
  }

  Future<void> _onSlotAdd(BuildContext context) async {
    loggy.info('Lets bottom sheet');
    final slot = await showModalBottomSheet<dynamic>(
      context: context,
      elevation: 3.0,
      builder: (context) => SizedBox(
        height: 300.0,
        child: Column(
          spacing: kListSpacingMedium,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Create a slot'),
            Padding(
              padding: const EdgeInsets.all(kPaddingMedium),
              child: SlotForm(),
            ),
          ],
        ),
      ),
    );

    loggy.info('return val', slot);
    slot == null
        ? loggy.info("cancelled")
        : loggy.info('Accepted');
  }
}
