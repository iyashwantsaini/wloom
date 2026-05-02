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
      ],
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
