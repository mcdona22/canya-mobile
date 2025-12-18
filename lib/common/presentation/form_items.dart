import 'package:flutter/material.dart';

typedef NavigationCallback = void Function();
typedef ControllerOutcomeCallBack =
    void Function(String? feedbackMessage);

const kBorderRadius = 5.0;

final textInputBorder = OutlineInputBorder(
  borderRadius: BorderRadius.circular(kBorderRadius),
);
