import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import '../catalog_scaffold.dart';

class DisplayPage extends StatelessWidget {
  const DisplayPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CatalogScaffold(
      title: 'Display',
      sections: [
        Section(
          label: 'Badges, chips, pills',
          children: [
            Wrap(
              spacing: WlmTokens.spaceSm,
              runSpacing: WlmTokens.spaceSm,
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const WlmBadge(label: 'Beta'),
                WlmBadge(label: 'New', color: scheme.secondary),
                const WlmPill(label: 'Wh'),
                WlmChip(label: 'Nature', onTap: () {}),
                WlmChip(label: 'Galaxy', onTap: () {}, filled: true),
                WlmChip(label: 'Selected', onTap: () {}, selected: true),
                WlmTag(label: 'closable', onRemove: () {}),
                const WlmKbd('⌘'),
                const WlmKbd('K'),
              ],
            ),
          ],
        ),
        const Section(
          label: 'Avatars',
          children: [
            Row(
              children: [
                WlmAvatar(initials: 'YS'),
                SizedBox(width: WlmTokens.spaceMd),
                WlmAvatar(initials: 'AC', shape: WlmAvatarShape.circle),
                SizedBox(width: WlmTokens.spaceMd),
                WlmAvatar(initials: 'JD', size: 56),
                SizedBox(width: WlmTokens.spaceLg),
                WlmAvatarStack(
                  avatars: [
                    WlmAvatar(initials: 'YS'),
                    WlmAvatar(initials: 'AC'),
                    WlmAvatar(initials: 'JD'),
                    WlmAvatar(initials: 'MK'),
                    WlmAvatar(initials: 'RT'),
                    WlmAvatar(initials: 'BL'),
                  ],
                ),
              ],
            ),
          ],
        ),
        const Section(
          label: 'Stats',
          children: [
            Row(
              children: [
                Expanded(
                  child: WlmStat(
                    label: 'Downloads',
                    value: '12,403',
                    trend: '+12.4%',
                    trendPositive: true,
                  ),
                ),
                SizedBox(width: WlmTokens.spaceLg),
                Expanded(
                  child: WlmStat(
                    label: 'Stars',
                    value: '948',
                    trend: '+34',
                    trendPositive: true,
                  ),
                ),
                SizedBox(width: WlmTokens.spaceLg),
                Expanded(
                  child: WlmStat(
                    label: 'Errors',
                    value: '3',
                    trend: '−2',
                    trendPositive: false,
                  ),
                ),
              ],
            ),
          ],
        ),
        const Section(
          label: 'Spec rows',
          children: [
            WlmSpecRow(label: 'Sources', value: 'WALLHAVEN · REDDIT · NASA'),
            WlmSpecRow(label: 'Tracking', value: 'NONE'),
            WlmSpecRow(label: 'Storage', value: 'ON DEVICE'),
          ],
        ),
        const Section(
          label: 'Callouts',
          children: [
            WlmCallout(
              tone: WlmCalloutTone.info,
              title: 'Heads up',
              body: 'Wolwoloom restyles every Material widget — drop-in friendly.',
            ),
            WlmCallout(
              tone: WlmCalloutTone.success,
              body: 'All systems green. Last build passed in 42s.',
            ),
            WlmCallout(
              tone: WlmCalloutTone.warning,
              title: 'Heads up',
              body: 'You are running on a debug build.',
            ),
            WlmCallout(
              tone: WlmCalloutTone.danger,
              title: 'Build failed',
              body: 'Check the analyzer output before pushing.',
            ),
          ],
        ),
        const Section(
          label: 'Code block',
          children: [
            WlmCodeBlock(
              language: 'dart',
              code: "import 'package:wolwoloom/wolwoloom.dart';\n\n"
                  'MaterialApp(\n'
                  '  theme: WlmTheme.light(),\n'
                  '  darkTheme: WlmTheme.dark(),\n'
                  ');',
            ),
          ],
        ),
        const Section(
          label: 'Progress',
          children: [
            WlmProgressBar(label: 'BUILDING', value: 0.62),
            WlmProgressBar(label: 'INDETERMINATE', value: null),
            Row(
              children: [
                WlmProgressRing(value: 0.62, size: 28),
                SizedBox(width: WlmTokens.spaceLg),
                WlmProgressRing(size: 28),
              ],
            ),
          ],
        ),
        Section(
          label: 'Tooltip & divider',
          children: [
            Row(
              children: [
                WlmTooltip(
                  message: 'Saved to favourites',
                  child: const WlmIconButton(
                    icon: Icons.bookmark_outline,
                    onPressed: null,
                  ),
                ),
                const SizedBox(width: WlmTokens.spaceLg),
                Text(
                  'Hover (or long-press) the icon →',
                  style: WlmType.meta(scheme.outline),
                ),
              ],
            ),
            const WlmDivider(),
          ],
        ),
      ],
    );
  }
}
