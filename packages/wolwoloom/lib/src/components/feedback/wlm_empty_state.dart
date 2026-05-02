import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Minimal empty-state — eyebrow + headline + body + optional action.
class WlmEmptyState extends StatelessWidget {
  const WlmEmptyState({
    super.key,
    required this.title,
    this.eyebrow = 'EMPTY',
    this.body,
    this.icon,
    this.action,
  });

  final String title;
  final String eyebrow;
  final String? body;
  final IconData? icon;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(WlmTokens.spaceXl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 28, color: scheme.outline),
            const SizedBox(height: WlmTokens.spaceLg),
          ],
          Text(
            eyebrow.toUpperCase(),
            style: WlmType.label(scheme.outline).copyWith(letterSpacing: 1.6),
          ),
          const SizedBox(height: WlmTokens.spaceSm),
          Text(title, style: WlmType.h1(scheme.onSurface)),
          if (body != null) ...[
            const SizedBox(height: WlmTokens.spaceSm),
            Text(
              body!,
              style: WlmType.bodySmall(scheme.outline).copyWith(height: 1.5),
            ),
          ],
          if (action != null) ...[
            const SizedBox(height: WlmTokens.spaceLg),
            action!,
          ],
        ],
      ),
    );
  }
}
