import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../buttons/wlm_secondary_button.dart';

/// Error state — sister of `WlmEmptyState` but with an "ERROR" eyebrow,
/// optional details block, and a built-in retry button.
class WlmErrorState extends StatelessWidget {
  const WlmErrorState({
    super.key,
    required this.title,
    this.body,
    this.details,
    this.onRetry,
    this.retryLabel = 'TRY AGAIN',
  });

  final String title;
  final String? body;
  final String? details;
  final VoidCallback? onRetry;
  final String retryLabel;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(WlmTokens.spaceXl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ERROR',
            style: WlmType.label(scheme.error).copyWith(letterSpacing: 1.6),
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
          if (details != null) ...[
            const SizedBox(height: WlmTokens.spaceMd),
            Container(
              padding: const EdgeInsets.all(WlmTokens.spaceMd),
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(WlmTokens.radSm),
                border: WlmTokens.hairlineBorder(scheme),
              ),
              child: Text(details!, style: WlmType.tiny(scheme.outline)),
            ),
          ],
          if (onRetry != null) ...[
            const SizedBox(height: WlmTokens.spaceLg),
            WlmSecondaryButton(
              label: retryLabel,
              icon: Icons.refresh_rounded,
              onPressed: onRetry,
            ),
          ],
        ],
      ),
    );
  }
}
