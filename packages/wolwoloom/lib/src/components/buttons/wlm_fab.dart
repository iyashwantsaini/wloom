import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Square floating action button — wloom keeps the FAB rectangular
/// so it shares the kit's visual language. Icon + optional ALL-CAPS
/// label.
class WlmFab extends StatelessWidget {
  const WlmFab({
    super.key,
    required this.icon,
    required this.onPressed,
    this.label,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final String? label;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final body = Material(
      color: scheme.onSurface,
      borderRadius: BorderRadius.circular(WlmTokens.radMd),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(WlmTokens.radMd),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: label == null ? WlmTokens.spaceMd : WlmTokens.spaceLg,
            vertical: WlmTokens.spaceMd,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: scheme.surface, size: 16),
              if (label != null) ...[
                const SizedBox(width: WlmTokens.spaceSm),
                Text(
                  label!.toUpperCase(),
                  style: WlmType.label(scheme.surface).copyWith(letterSpacing: 1.4),
                ),
              ],
            ],
          ),
        ),
      ),
    );
    return tooltip == null ? body : Tooltip(message: tooltip!, child: body);
  }
}
