import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// "Spec sheet" key/value row — left-aligned ALL-CAPS key in a fixed
/// column, mono value beside it. Echoes the onboarding/about screens in
/// the wolwo app.
class WlmSpecRow extends StatelessWidget {
  const WlmSpecRow({
    super.key,
    required this.label,
    required this.value,
    this.labelWidth = 96,
  });

  final String label;
  final String value;
  final double labelWidth;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: WlmTokens.spaceSm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: labelWidth,
            child: Text(
              label.toUpperCase(),
              style: WlmType.label(scheme.outline).copyWith(letterSpacing: 1.4),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: WlmType.tiny(scheme.onSurface).copyWith(
                letterSpacing: 0.8,
                fontSize: 11,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
