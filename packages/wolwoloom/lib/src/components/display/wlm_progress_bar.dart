import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Linear progress bar — hairline track with an ink fill. Set [value]
/// to `null` for an indeterminate animation.
class WlmProgressBar extends StatelessWidget {
  const WlmProgressBar({
    super.key,
    this.value,
    this.height = 2,
    this.label,
  });

  final double? value;
  final double height;
  final String? label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Row(
            children: [
              Expanded(
                child: Text(
                  label!.toUpperCase(),
                  style: WlmType.label(scheme.outline),
                ),
              ),
              if (value != null)
                Text(
                  '${(value! * 100).round()}%',
                  style: WlmType.tiny(scheme.outline),
                ),
            ],
          ),
          const SizedBox(height: WlmTokens.spaceSm),
        ],
        ClipRRect(
          borderRadius: BorderRadius.circular(height / 2),
          child: LinearProgressIndicator(
            value: value,
            minHeight: height,
            backgroundColor: scheme.outlineVariant.withValues(alpha: 0.30),
            valueColor: AlwaysStoppedAnimation<Color>(scheme.onSurface),
          ),
        ),
      ],
    );
  }
}
