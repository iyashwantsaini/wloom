import 'package:flutter/material.dart';

import '../../theme/wlm_theme_extension.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../display/wlm_callout.dart';

/// Full-width inline banner. Same colour-tone vocabulary as
/// `WlmCallout`, but stretches edge-to-edge and supports a primary
/// dismiss action.
class WlmBanner extends StatelessWidget {
  const WlmBanner({
    super.key,
    required this.message,
    this.title,
    this.tone = WlmCalloutTone.info,
    this.actionLabel,
    this.onAction,
    this.onDismiss,
  });

  final String message;
  final String? title;
  final WlmCalloutTone tone;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback? onDismiss;

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

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = _toneColor(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: WlmTokens.spaceLg,
        vertical: WlmTokens.spaceMd,
      ),
      decoration: BoxDecoration(
        color: c.withValues(alpha: 0.06),
        border: Border(
          top: BorderSide(color: c.withValues(alpha: 0.40), width: 1),
          bottom: BorderSide(color: c.withValues(alpha: 0.40), width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (title != null) ...[
                  Text(title!, style: WlmType.h3(scheme.onSurface)),
                  const SizedBox(height: 2),
                ],
                Text(
                  message,
                  style: WlmType.bodySmall(scheme.onSurfaceVariant),
                ),
              ],
            ),
          ),
          if (actionLabel != null) ...[
            const SizedBox(width: WlmTokens.spaceMd),
            InkWell(
              onTap: onAction,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: WlmTokens.spaceSm,
                  vertical: WlmTokens.spaceXs,
                ),
                child: Text(actionLabel!.toUpperCase(), style: WlmType.label(c)),
              ),
            ),
          ],
          if (onDismiss != null)
            IconButton(
              icon: Icon(Icons.close_rounded, size: 16, color: scheme.outline),
              onPressed: onDismiss,
            ),
        ],
      ),
    );
  }
}
