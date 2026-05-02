import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Closable / removable chip — like `WlmChip` but with a trailing `×`.
class WlmTag extends StatelessWidget {
  const WlmTag({
    super.key,
    required this.label,
    this.onRemove,
    this.onTap,
    this.color,
  });

  final String label;
  final VoidCallback? onRemove;
  final VoidCallback? onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = color ?? scheme.onSurface;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(WlmTokens.radSm),
      child: Container(
        padding: const EdgeInsets.fromLTRB(WlmTokens.spaceSm, 4, WlmTokens.spaceXs, 4),
        decoration: BoxDecoration(
          color: c.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(WlmTokens.radSm),
          border: Border.all(color: c.withValues(alpha: 0.40), width: 0.6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: WlmType.tiny(c).copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
            if (onRemove != null) ...[
              const SizedBox(width: 4),
              InkResponse(
                radius: 12,
                onTap: onRemove,
                child: Icon(Icons.close_rounded, size: 12, color: c),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
