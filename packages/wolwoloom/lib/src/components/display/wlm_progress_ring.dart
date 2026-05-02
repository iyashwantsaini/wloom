import 'package:flutter/material.dart';

/// Circular progress ring with a hairline track. Pass [value] for
/// determinate, leave null for indeterminate.
class WlmProgressRing extends StatelessWidget {
  const WlmProgressRing({
    super.key,
    this.value,
    this.size = 24,
    this.strokeWidth = 2,
  });

  final double? value;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        value: value,
        strokeWidth: strokeWidth,
        color: scheme.onSurface,
        backgroundColor: scheme.outlineVariant.withValues(alpha: 0.30),
      ),
    );
  }
}
