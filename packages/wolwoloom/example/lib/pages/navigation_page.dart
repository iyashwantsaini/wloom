import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import '../catalog_scaffold.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});
  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _bottom = 0;
  int _tab = 0;
  int _page = 1;
  static const _pageCount = 12;

  @override
  Widget build(BuildContext context) {
    return CatalogScaffold(
      title: 'Navigation',
      sections: [
        Section(
          label: 'Bottom nav',
          children: [
            WlmBottomNav(
              currentIndex: _bottom,
              onTap: (i) => setState(() => _bottom = i),
              items: const [
                WlmNavItem(
                  icon: Icons.home_outlined,
                  activeIcon: Icons.home,
                  label: 'Home',
                ),
                WlmNavItem(icon: Icons.search_rounded, label: 'Search'),
                WlmNavItem(icon: Icons.bookmark_outline, label: 'Saved'),
                WlmNavItem(icon: Icons.settings_outlined, label: 'Settings'),
              ],
            ),
          ],
        ),
        Section(
          label: 'Tab bar',
          children: [
            WlmTabBar(
              currentIndex: _tab,
              onTap: (i) => setState(() => _tab = i),
              tabs: const [
                WlmTab(label: 'Curated'),
                WlmTab(label: 'Latest'),
                WlmTab(label: 'Favourites'),
              ],
            ),
          ],
        ),
        const Section(
          label: 'Step dots',
          children: [
            WlmStepDots(total: 4, index: 1),
          ],
        ),
        Section(
          label: 'Shell',
          caption: 'Adaptive bottom nav ↔ NavigationRail at the medium breakpoint.',
          children: [
            WlmGhostButton(
              label: 'OPEN SHELL',
              icon: Icons.open_in_new_rounded,
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (_) => const _ShellDemo(),
                ),
              ),
            ),
          ],
        ),
        Section(
          label: 'Pagination',
          caption: 'Numbered when ≤ 7 pages, compact otherwise.',
          children: [
            WlmPagination(
              page: _page,
              pageCount: _pageCount,
              hasPrevious: _page > 1,
              hasNext: _page < _pageCount,
              onPageChanged: (p) => setState(() => _page = p),
            ),
          ],
        ),
        Section(
          label: 'Page transitions',
          caption:
              'WlmPageRoute factories — fade, sharedAxis, fadeThrough. Honours reduced-motion.',
          children: [
            Wrap(
              spacing: WlmTokens.spaceSm,
              runSpacing: WlmTokens.spaceSm,
              children: [
                WlmGhostButton(
                  label: 'FADE',
                  onPressed: () => Navigator.of(context).push(
                    WlmPageRoute<void>.fade(
                      builder: (_) => const _TransitionDemo(label: 'fade'),
                    ),
                  ),
                ),
                WlmGhostButton(
                  label: 'SHARED AXIS',
                  onPressed: () => Navigator.of(context).push(
                    WlmPageRoute<void>.sharedAxis(
                      builder: (_) =>
                          const _TransitionDemo(label: 'shared axis'),
                    ),
                  ),
                ),
                WlmGhostButton(
                  label: 'FADE THROUGH',
                  onPressed: () => Navigator.of(context).push(
                    WlmPageRoute<void>.fadeThrough(
                      builder: (_) =>
                          const _TransitionDemo(label: 'fade through'),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Section(
          label: 'Focusable',
          caption:
              'Wrap any custom tappable to get an on-brand keyboard focus ring.',
          children: [
            const _FocusableDemo(),
          ],
        ),
      ],
    );
  }
}

class _TransitionDemo extends StatelessWidget {
  const _TransitionDemo({required this.label});
  final String label;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: WlmAppBar(
        title: label,
        leading: WlmHeaderIconButton(
          icon: Icons.arrow_back_rounded,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        showDivider: true,
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('PUSHED VIA', style: WlmType.label(scheme.outline)),
            const SizedBox(height: WlmTokens.spaceSm),
            Text(
              'WlmPageRoute.${label.replaceAll(' ', '')}',
              style: WlmType.h2(scheme.onSurface),
            ),
          ],
        ),
      ),
    );
  }
}

class _FocusableDemo extends StatelessWidget {
  const _FocusableDemo();
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return WlmFocusable(
      onTap: () {},
      semanticLabel: 'Open settings',
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: WlmTokens.spaceMd,
          vertical: WlmTokens.spaceMd,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(WlmTokens.radSm),
          border: WlmTokens.hairlineBorder(scheme),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.tune_rounded, size: 18),
            const SizedBox(width: WlmTokens.spaceSm),
            Text('Tab to focus me', style: WlmType.body(scheme.onSurface)),
          ],
        ),
      ),
    );
  }
}

class _ShellDemo extends StatelessWidget {
  const _ShellDemo();
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return WlmShell(
      appBarTitle: 'Shell demo',
      items: const [
        WlmNavItem(
          icon: Icons.home_outlined,
          activeIcon: Icons.home,
          label: 'Home',
        ),
        WlmNavItem(icon: Icons.search_rounded, label: 'Search'),
        WlmNavItem(icon: Icons.bookmark_outline, label: 'Saved'),
      ],
      builder: (ctx, i) => Center(
        child: Text('Tab $i', style: WlmType.h1(scheme.onSurface)),
      ),
    );
  }
}
