import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Mono list tile. Three slots — leading, title/subtitle stack,
/// trailing — separated by `WlmTokens.spaceLg` and padded by the
/// standard hairline-row insets.
class WlmListTile extends StatelessWidget {
  const WlmListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.dense = false,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: WlmTokens.spaceLg,
          vertical: dense ? WlmTokens.spaceSm : WlmTokens.spaceMd,
        ),
        child: Row(
          children: [
            if (leading != null) ...[
              leading!,
              const SizedBox(width: WlmTokens.spaceLg),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: WlmType.body(scheme.onSurface)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(
                      subtitle!,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: WlmType.meta(scheme.outline),
                    ),
                  ],
                ],
              ),
            ),
            if (trailing != null) ...[
              const SizedBox(width: WlmTokens.spaceMd),
              trailing!,
            ],
          ],
        ),
      ),
    );
  }
}
