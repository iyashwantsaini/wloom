import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Translucent ink pill — wolwo's `_SourcePill` shape. Used for tags
/// overlaid on imagery, where contrast is unpredictable.
class WlmPill extends StatelessWidget {
  const WlmPill({
    super.key,
    required this.label,
    this.background = const Color(0xCC000000),
    this.foreground = Colors.white,
  });

  final String label;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(WlmTokens.radSm - 2),
        border: Border.all(
          color: foreground.withValues(alpha: 0.18),
          width: 0.6,
        ),
      ),
      child: Text(
        label.toUpperCase(),
        style: WlmType.tiny(foreground).copyWith(
          fontSize: 8.5,
          letterSpacing: 0.8,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
