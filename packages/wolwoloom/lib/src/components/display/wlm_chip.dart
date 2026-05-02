import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Tappable mono chip used in the wolwo search "TRY"/"RECENT" rows.
///
/// Two looks: [filled] = `surfaceContainerHighest` background, hairline
/// border. `filled = false` = transparent background, hairline border —
/// reads as a quieter suggestion chip.
class WlmChip extends StatelessWidget {
  const WlmChip({
    super.key,
    required this.label,
    this.onTap,
    this.filled = false,
    this.selected = false,
    this.icon,
  });

  final String label;
  final VoidCallback? onTap;
  final bool filled;
  final bool selected;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fg = selected ? scheme.surface : scheme.onSurfaceVariant;
    final bg = selected
        ? scheme.onSurface
        : (filled ? scheme.surfaceContainerHighest : Colors.transparent);
    final border = selected
        ? scheme.onSurface
        : scheme.outlineVariant.withValues(alpha: 0.30);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(WlmTokens.radMd),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: WlmTokens.spaceMd,
          vertical: WlmTokens.spaceSm,
        ),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(WlmTokens.radMd),
          border: Border.all(color: border, width: WlmTokens.hairline),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 12, color: fg),
              const SizedBox(width: WlmTokens.spaceXs + 2),
            ],
            Text(
              label.toUpperCase(),
              style: WlmType.tiny(fg).copyWith(
                fontSize: 11,
                letterSpacing: 1.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
