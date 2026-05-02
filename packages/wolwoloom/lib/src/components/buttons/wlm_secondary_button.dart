import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Hairline-outlined secondary button. Same footprint as
/// [WlmPrimaryButton] but transparent fill and a 1px border.
class WlmSecondaryButton extends StatelessWidget {
  const WlmSecondaryButton({
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
    final fg = disabled ? scheme.outline : scheme.onSurface;

    final btn = InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(WlmTokens.radMd),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: WlmTokens.spaceLg,
          vertical: WlmTokens.spaceMd,
        ),
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(WlmTokens.radMd),
          border: Border.all(color: fg, width: WlmTokens.hairline),
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
