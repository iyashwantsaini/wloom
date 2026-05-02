import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Side drawer with mono header, ALL-CAPS section labels and hairline
/// borders.
class WlmDrawer extends StatelessWidget {
  const WlmDrawer({
    super.key,
    required this.title,
    this.subtitle,
    this.children = const [],
    this.footer,
    this.width = 280,
  });

  final String title;
  final String? subtitle;
  final List<Widget> children;
  final Widget? footer;
  final double width;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Drawer(
      backgroundColor: scheme.surface,
      width: width,
      shape: RoundedRectangleBorder(
        side: WlmTokens.hairlineSide(scheme),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(WlmTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: WlmType.h2(scheme.onSurface)),
                  if (subtitle != null) ...[
                    const SizedBox(height: 2),
                    Text(subtitle!, style: WlmType.meta(scheme.outline)),
                  ],
                ],
              ),
            ),
            Container(
              height: WlmTokens.hairline,
              color: scheme.outlineVariant.withValues(alpha: 0.30),
            ),
            Expanded(child: ListView(children: children)),
            if (footer != null) ...[
              Container(
                height: WlmTokens.hairline,
                color: scheme.outlineVariant.withValues(alpha: 0.30),
              ),
              Padding(
                padding: const EdgeInsets.all(WlmTokens.spaceLg),
                child: footer!,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
