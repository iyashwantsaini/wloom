import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Filled ink button. Wolwoloom's primary call-to-action.
///
/// Reads as "wet ink on paper" — solid `onSurface` background, surface
/// foreground. ALL-CAPS mono label by default, but [uppercase] can be
/// disabled for proper-cased CTAs.
class WlmPrimaryButton extends StatelessWidget {
  const WlmPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.uppercase = true,
    this.expand = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool uppercase;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final disabled = onPressed == null;
    final fg = disabled ? scheme.surface.withValues(alpha: 0.5) : scheme.surface;
    final bg = disabled ? scheme.onSurface.withValues(alpha: 0.4) : scheme.onSurface;

    final btn = InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(WlmTokens.radMd),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: WlmTokens.spaceLg,
          vertical: WlmTokens.spaceMd,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(WlmTokens.radMd),
        ),
        child: Row(
          mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
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

    return expand ? SizedBox(width: double.infinity, child: btn) : btn;
  }
}
