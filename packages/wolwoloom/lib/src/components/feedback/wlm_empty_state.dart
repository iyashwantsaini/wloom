import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Minimal empty-state — eyebrow + headline + body + optional action(s).
class WlmEmptyState extends StatelessWidget {
  const WlmEmptyState({
    super.key,
    required this.title,
    this.eyebrow = 'EMPTY',
    this.body,
    this.icon,
    this.illustration,
    this.action,
    this.secondaryAction,
    this.alignment = CrossAxisAlignment.start,
  });

  final String title;
  final String eyebrow;
  final String? body;

  /// Inline glyph rendered above the eyebrow. Ignored when
  /// [illustration] is provided.
  final IconData? icon;

  /// Custom illustration slot — takes precedence over [icon]. Wrap in
  /// `SizedBox` to constrain it.
  final Widget? illustration;

  /// Primary CTA (typically a `WlmPrimaryButton`).
  final Widget? action;

  /// Optional secondary CTA rendered below [action] (typically a
  /// `WlmGhostButton`).
  final Widget? secondaryAction;

  final CrossAxisAlignment alignment;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final centered = alignment == CrossAxisAlignment.center;
    return Padding(
      padding: const EdgeInsets.all(WlmTokens.spaceXl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: alignment,
        children: [
          if (illustration != null) ...[
            illustration!,
            const SizedBox(height: WlmTokens.spaceLg),
          ] else if (icon != null) ...[
            Icon(icon, size: 28, color: scheme.outline),
            const SizedBox(height: WlmTokens.spaceLg),
          ],
          Text(
            eyebrow.toUpperCase(),
            textAlign: centered ? TextAlign.center : TextAlign.start,
            style: WlmType.label(scheme.outline).copyWith(letterSpacing: 1.6),
          ),
          const SizedBox(height: WlmTokens.spaceSm),
          Text(
            title,
            textAlign: centered ? TextAlign.center : TextAlign.start,
            style: WlmType.h1(scheme.onSurface),
          ),
          if (body != null) ...[
            const SizedBox(height: WlmTokens.spaceSm),
            Text(
              body!,
              textAlign: centered ? TextAlign.center : TextAlign.start,
              style: WlmType.bodySmall(scheme.outline).copyWith(height: 1.5),
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: WlmTokens.spaceLg),
            action!,
          ],
          if (secondaryAction != null) ...[
            const SizedBox(height: WlmTokens.spaceSm),
            secondaryAction!,
          ],
        ],
      ),
    );
  }
}
