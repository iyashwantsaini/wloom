import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';

/// Compact icon button used in `WlmPageHeader.actions`. Same footprint
/// as the action chips in the wolwo home / search headers — square,
/// hairline outlined, with an optional tiny accent badge dot.
class WlmHeaderIconButton extends StatelessWidget {
  const WlmHeaderIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.badge = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final bool badge;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = onPressed == null ? scheme.outline : scheme.onSurface;

    final body = InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(WlmTokens.radSm),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(WlmTokens.radSm),
          border: Border.all(
            color: scheme.outlineVariant.withValues(alpha: 0.30),
            width: WlmTokens.hairline,
          ),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Icon(icon, size: 16, color: fg),
            if (badge)
              Positioned(
                top: 6,
                right: 6,
                child: Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: scheme.secondary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
          ],
        ),
      ),
    );

    return tooltip == null ? body : Tooltip(message: tooltip!, child: body);
  }
}
