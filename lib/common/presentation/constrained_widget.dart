import 'package:canya/common/dimensions.dart';
import 'package:flutter/material.dart';

class ConstrainedWidget extends StatelessWidget {
  final double minWidth = kMobileWidth;
  final double maxWidth;
  final Widget child;

  const ConstrainedWidget({
    required this.child,
    required this.maxWidth,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: minWidth,
        maxWidth: maxWidth,
      ),
      child: child,
    );
  }
}
