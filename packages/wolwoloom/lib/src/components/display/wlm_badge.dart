import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Tiny tinted badge ("BETA", "NEW", "RECOMMENDED"). The wolwo `_Pill`
/// pattern: tint at 15% alpha, hairline border at 40% alpha, ALL-CAPS
/// label.
class WlmBadge extends StatelessWidget {
  const WlmBadge({
    super.key,
    required this.label,
    this.color,
  });

  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = color ?? scheme.onSurface;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(WlmTokens.radSm),
        border: Border.all(color: c.withValues(alpha: 0.4), width: 0.5),
      ),
      child: Text(
        label.toUpperCase(),
        style: WlmType.tiny(c).copyWith(
          fontSize: 10,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.4,
        ),
      ),
    );
  }
}
