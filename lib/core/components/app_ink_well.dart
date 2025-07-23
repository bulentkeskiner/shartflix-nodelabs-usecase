import 'package:flutter/material.dart';

class AppInkWell extends InkWell {
  const AppInkWell({
    super.key,
    super.child,
    super.onTap,
    super.customBorder,
    super.borderRadius,
  }) : super(overlayColor: const WidgetStatePropertyAll(Colors.transparent));
}
