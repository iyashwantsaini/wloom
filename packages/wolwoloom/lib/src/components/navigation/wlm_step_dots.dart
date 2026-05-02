import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';

/// Tiny step-progress dots row used by onboarding and multi-step flows.
class WlmStepDots extends StatelessWidget {
  const WlmStepDots({
    super.key,
    required this.total,
    required this.index,
  });

  final int total;
  final int index;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: WlmTokens.spaceLg,
        vertical: WlmTokens.spaceSm,
      ),
      child: Row(
        children: [
          for (var i = 0; i < total; i++) ...[
            Expanded(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 220),
                height: 2,
                color: i <= index
                    ? scheme.onSurface
                    : scheme.outlineVariant.withValues(alpha: 0.30),
              ),
            ),
            if (i != total - 1) const SizedBox(width: WlmTokens.spaceXs),
          ],
        ],
      ),
    );
  }
}
