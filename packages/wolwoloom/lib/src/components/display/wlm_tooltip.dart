import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Themed tooltip — dark ink pill with mono caption.
class WlmTooltip extends StatelessWidget {
  const WlmTooltip({
    super.key,
    required this.message,
    required this.child,
    this.preferBelow,
  });

  final String message;
  final Widget child;
  final bool? preferBelow;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Tooltip(
      message: message,
      preferBelow: preferBelow,
      decoration: BoxDecoration(
        color: scheme.brightness == Brightness.dark
            ? scheme.surfaceContainerHighest
            : Colors.black,
        borderRadius: BorderRadius.circular(WlmTokens.radSm),
        border: Border.all(
          color: scheme.outlineVariant.withValues(alpha: 0.40),
          width: 1,
        ),
      ),
      textStyle: WlmType.tiny(Colors.white).copyWith(fontSize: 11),
      padding: const EdgeInsets.symmetric(
        horizontal: WlmTokens.spaceSm,
        vertical: WlmTokens.spaceXs,
      ),
      child: child,
    );
  }
}
