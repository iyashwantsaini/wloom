import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Editorial page header. Renders an ALL-CAPS [eyebrow], a [title]
/// (h1, mono), an optional [subtitle], and a row of trailing [actions]
/// (typically `WlmHeaderIconButton`s).
class WlmPageHeader extends StatelessWidget {
  const WlmPageHeader({
    super.key,
    required this.title,
    this.eyebrow,
    this.subtitle,
    this.actions = const [],
    this.padding = const EdgeInsets.fromLTRB(
      WlmTokens.spaceLg,
      WlmTokens.spaceXl,
      WlmTokens.spaceLg,
      WlmTokens.spaceMd,
    ),
  });

  final String title;
  final String? eyebrow;
  final String? subtitle;
  final List<Widget> actions;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (eyebrow != null)
                  Padding(
                    padding: const EdgeInsets.only(bottom: WlmTokens.spaceXs),
                    child: Text(
                      eyebrow!.toUpperCase(),
                      style: WlmType.label(scheme.outline)
                          .copyWith(letterSpacing: 1.6),
                    ),
                  ),
                Text(title, style: WlmType.h1(scheme.onSurface)),
                if (subtitle != null) ...[
                  const SizedBox(height: WlmTokens.spaceXs),
                  Text(subtitle!, style: WlmType.meta(scheme.outline)),
                ],
              ],
            ),
          ),
          if (actions.isNotEmpty)
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                for (var i = 0; i < actions.length; i++) ...[
                  if (i > 0) const SizedBox(width: WlmTokens.spaceSm),
                  actions[i],
                ],
              ],
            ),
        ],
      ),
    );
  }
}
