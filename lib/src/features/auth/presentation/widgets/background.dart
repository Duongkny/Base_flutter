import 'package:flutter/material.dart';
import 'package:base_flutter/src/core/extension/context.dart';

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colorScheme.surfaceDim,
    );
  }
}
