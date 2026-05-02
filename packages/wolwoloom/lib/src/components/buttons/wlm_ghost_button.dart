import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Tertiary text-only button (ALL-CAPS mono, optional leading icon).
class WlmGhostButton extends StatelessWidget {
  const WlmGhostButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.uppercase = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool uppercase;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final disabled = onPressed == null;
    final fg = disabled ? scheme.outline : scheme.onSurface;

    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(WlmTokens.radSm),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: WlmTokens.spaceMd,
          vertical: WlmTokens.spaceSm,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 14, color: fg),
              const SizedBox(width: WlmTokens.spaceSm),
            ],
            Text(
              uppercase ? label.toUpperCase() : label,
              style: WlmType.label(fg).copyWith(letterSpacing: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
