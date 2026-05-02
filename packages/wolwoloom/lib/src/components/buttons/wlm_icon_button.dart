import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';

/// Compact icon-only button. Square hit target, hairline outlined when
/// [outlined] is true, otherwise transparent.
class WlmIconButton extends StatelessWidget {
  const WlmIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.tooltip,
    this.size = 18,
    this.outlined = false,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? tooltip;
  final double size;
  final bool outlined;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final disabled = onPressed == null;
    final fg = disabled ? scheme.outline : scheme.onSurface;

    final core = InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(WlmTokens.radSm),
      child: Container(
        width: WlmTokens.tapTarget,
        height: WlmTokens.tapTarget,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(WlmTokens.radSm),
          border: outlined ? Border.all(color: fg, width: WlmTokens.hairline) : null,
        ),
        child: Icon(icon, size: size, color: fg),
      ),
    );

    return tooltip == null ? core : Tooltip(message: tooltip!, child: core);
  }
}
