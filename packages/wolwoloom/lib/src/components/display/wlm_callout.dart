import 'package:flutter/material.dart';

import '../../theme/wlm_theme_extension.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

enum WlmCalloutTone { info, success, warning, danger, neutral }

/// Inline informational card. A coloured hairline border and matching
/// icon mark the [tone]; body and optional title use the standard mono
/// styles.
class WlmCallout extends StatelessWidget {
  const WlmCallout({
    super.key,
    required this.body,
    this.title,
    this.tone = WlmCalloutTone.info,
    this.icon,
    this.action,
  });

  final String body;
  final String? title;
  final WlmCalloutTone tone;
  final IconData? icon;
  final Widget? action;

  Color _toneColor(BuildContext c) {
    final wlm = WlmThemeExtension.of(c);
    return switch (tone) {
      WlmCalloutTone.info => wlm.info,
      WlmCalloutTone.success => wlm.success,
      WlmCalloutTone.warning => wlm.warning,
      WlmCalloutTone.danger => wlm.danger,
      WlmCalloutTone.neutral => Theme.of(c).colorScheme.onSurface,
    };
  }

  IconData _toneIcon() => switch (tone) {
        WlmCalloutTone.info => Icons.info_outline_rounded,
        WlmCalloutTone.success => Icons.check_circle_outline_rounded,
        WlmCalloutTone.warning => Icons.warning_amber_rounded,
        WlmCalloutTone.danger => Icons.error_outline_rounded,
        WlmCalloutTone.neutral => Icons.notes_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = _toneColor(context);
    return Container(
      padding: const EdgeInsets.all(WlmTokens.spaceMd),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(WlmTokens.radMd),
        border: Border.all(color: c.withValues(alpha: 0.40), width: 1),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon ?? _toneIcon(), size: 16, color: c),
          const SizedBox(width: WlmTokens.spaceMd),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(
                    title!,
                    style: WlmType.h3(scheme.onSurface).copyWith(fontSize: 13),
                  ),
                  const SizedBox(height: 2),
                ],
                Text(
                  body,
                  style: WlmType.bodySmall(scheme.onSurfaceVariant)
                      .copyWith(height: 1.45),
                ),
                if (action != null) ...[
                  const SizedBox(height: WlmTokens.spaceSm),
                  action!,
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
