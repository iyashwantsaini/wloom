import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import '../catalog_scaffold.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return CatalogScaffold(
      title: 'Layout',
      sections: [
        Section(
          label: 'Cards',
          children: [
            WlmCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Card title', style: WlmType.h2(scheme.onSurface)),
                  const SizedBox(height: WlmTokens.spaceSm),
                  Text(
                    'Solid surface, hairline border, no shadows. Use this for any '
                    'grouped content.',
                    style: WlmType.bodySmall(scheme.outline),
                  ),
                ],
              ),
            ),
            WlmCard(
              elevated: true,
              child: Text(
                'Elevated card — same hairline, slightly lifted surface for emphasis.',
                style: WlmType.bodySmall(scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
        const Section(
          label: 'Page header',
          children: [
            WlmPageHeader(
              eyebrow: 'design system',
              title: 'Wolwoloom',
              subtitle: 'Mono · hairline · editorial',
            ),
          ],
        ),
        Section(
          label: 'App bar',
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(WlmTokens.radSm),
              child: Container(
                color: scheme.surfaceContainerHighest,
                child: WlmAppBar(
                  title: 'Wolwoloom',
                  actions: [
                    WlmHeaderIconButton(
                      icon: Icons.search_rounded,
                      onPressed: () {},
                    ),
                  ],
                  showDivider: true,
                ),
              ),
            ),
          ],
        ),
        Section(
          label: 'Accordion',
          children: [
            WlmAccordion(
              title: 'How is this priced?',
              subtitle: 'TL;DR — free.',
              child: Text(
                'Wolwoloom is MIT-licensed and free forever. Use it commercially, '
                "fork it, redistribute it — just keep the notice.",
                style: WlmType.bodySmall(scheme.onSurfaceVariant)
                    .copyWith(height: 1.5),
              ),
            ),
            WlmAccordion(
              title: 'Does it work in dark mode?',
              child: Text(
                'Yes — every component reads from the active `ColorScheme`.',
                style: WlmType.bodySmall(scheme.onSurfaceVariant),
              ),
            ),
          ],
        ),
        Section(
          label: 'Breadcrumbs',
          children: [
            WlmBreadcrumbs(
              crumbs: [
                WlmCrumb('Home', onTap: () {}),
                WlmCrumb('Components', onTap: () {}),
                const WlmCrumb('Card'),
              ],
            ),
          ],
        ),
        Section(
          label: 'Drawer',
          children: [
            WlmGhostButton(
              label: 'OPEN DRAWER',
              icon: Icons.menu_rounded,
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  backgroundColor: Colors.transparent,
                  builder: (_) => SizedBox(
                    height: 480,
                    child: WlmDrawer(
                      title: 'Wolwoloom',
                      subtitle: 'Editorial design system',
                      children: const [
                        WlmListTile(title: 'Home'),
                        WlmListTile(title: 'Components'),
                        WlmListTile(title: 'Tokens'),
                        WlmListTile(title: 'About'),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
        const Section(
          label: 'Section label',
          children: [WlmSectionLabel('Recent')],
        ),
        Section(
          label: 'Centered column',
          caption:
              'WlmCenteredColumn caps width on wide screens — the canonical "form on desktop" pattern.',
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(WlmTokens.radSm),
                border: WlmTokens.hairlineBorder(scheme),
              ),
              padding: const EdgeInsets.symmetric(vertical: WlmTokens.spaceLg),
              child: WlmCenteredColumn(
                maxWidth: 360,
                child: Text(
                  'This column is capped at 360px and centred. '
                  'Use it for forms, prose, or any narrow content on desktop.',
                  style: WlmType.bodySmall(scheme.onSurface),
                ),
              ),
            ),
          ],
        ),
        Section(
          label: 'Responsive',
          caption:
              'WlmResponsive picks a builder per breakpoint. WlmResponsiveValue resolves a typed value.',
          children: [
            Container(
              padding: const EdgeInsets.all(WlmTokens.spaceLg),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(WlmTokens.radSm),
                border: WlmTokens.hairlineBorder(scheme),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'CURRENT BREAKPOINT',
                    style: WlmType.label(scheme.outline),
                  ),
                  const SizedBox(height: WlmTokens.spaceXs),
                  Text(
                    WlmBreakpoint.of(context).name,
                    style: WlmType.h2(scheme.onSurface),
                  ),
                  const SizedBox(height: WlmTokens.spaceMd),
                  Text(
                    'columns: ${const WlmResponsiveValue<int>(compact: 2, medium: 3, expanded: 4, large: 5).resolve(context)}',
                    style: WlmType.body(scheme.onSurface),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
