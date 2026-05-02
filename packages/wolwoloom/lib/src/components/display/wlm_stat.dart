import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Big-number metric tile. Eyebrow label + huge mono value + optional
/// trend caption ("+12.4%").
class WlmStat extends StatelessWidget {
  const WlmStat({
    super.key,
    required this.label,
    required this.value,
    this.trend,
    this.trendPositive,
  });

  final String label;
  final String value;
  final String? trend;
  final bool? trendPositive;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final trendColor = trendPositive == null
        ? scheme.outline
        : (trendPositive! ? scheme.onSurface : scheme.error);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label.toUpperCase(),
          style: WlmType.label(scheme.outline).copyWith(letterSpacing: 1.4),
        ),
        const SizedBox(height: WlmTokens.spaceSm),
        Text(
          value,
          style: WlmType.h1(scheme.onSurface).copyWith(
            fontSize: 32,
            fontWeight: FontWeight.w300,
            letterSpacing: -1.0,
          ),
        ),
        if (trend != null) ...[
          const SizedBox(height: WlmTokens.spaceXs),
          Row(
            children: [
              if (trendPositive != null)
                Icon(
                  trendPositive! ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
                  size: 12,
                  color: trendColor,
                ),
              const SizedBox(width: 2),
              Text(trend!, style: WlmType.meta(trendColor)),
            ],
          ),
        ],
      ],
    );
  }
}
