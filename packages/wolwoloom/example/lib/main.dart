import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import 'pages/buttons_page.dart';
import 'pages/display_page.dart';
import 'pages/feedback_page.dart';
import 'pages/foundations_page.dart';
import 'pages/inputs_page.dart';
import 'pages/layout_page.dart';
import 'pages/lists_page.dart';
import 'pages/media_page.dart';
import 'pages/navigation_page.dart';
import 'pages/overlays_page.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  ThemeMode _mode = ThemeMode.system;

  void _toggle() {
    setState(() {
      _mode = switch (_mode) {
        ThemeMode.system => ThemeMode.light,
        ThemeMode.light => ThemeMode.dark,
        ThemeMode.dark => ThemeMode.system,
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wolwoloom Catalog',
      theme: WlmTheme.light(),
      darkTheme: WlmTheme.dark(),
      themeMode: _mode,
      home: _CatalogHome(mode: _mode, onToggleTheme: _toggle),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _CatalogEntry {
  const _CatalogEntry({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.page,
  });
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget page;
}

const _entries = <_CatalogEntry>[
  _CatalogEntry(
    title: 'Foundations',
    subtitle: 'Tokens · type · palette',
    icon: Icons.format_paint_outlined,
    page: FoundationsPage(),
  ),
  _CatalogEntry(
    title: 'Buttons',
    subtitle: 'Primary · secondary · ghost · icon · FAB',
    icon: Icons.smart_button_outlined,
    page: ButtonsPage(),
  ),
  _CatalogEntry(
    title: 'Inputs',
    subtitle: 'Text · search · checkbox · slider · stepper',
    icon: Icons.edit_outlined,
    page: InputsPage(),
  ),
  _CatalogEntry(
    title: 'Display',
    subtitle: 'Avatars · tags · stats · callouts · code',
    icon: Icons.dashboard_outlined,
    page: DisplayPage(),
  ),
  _CatalogEntry(
    title: 'Layout',
    subtitle: 'Cards · accordion · breadcrumbs · drawer',
    icon: Icons.view_quilt_outlined,
    page: LayoutPage(),
  ),
  _CatalogEntry(
    title: 'Lists',
    subtitle: 'List · action · switch · checkbox · radio',
    icon: Icons.list_alt_outlined,
    page: ListsPage(),
  ),
  _CatalogEntry(
    title: 'Feedback',
    subtitle: 'Loaders · banners · toasts · empty/error',
    icon: Icons.notifications_none_rounded,
    page: FeedbackPage(),
  ),
  _CatalogEntry(
    title: 'Navigation',
    subtitle: 'Bottom nav · tabs · steps · shell',
    icon: Icons.alt_route_rounded,
    page: NavigationPage(),
  ),
  _CatalogEntry(
    title: 'Overlays',
    subtitle: 'Bottom sheet · dialog · tooltip',
    icon: Icons.layers_outlined,
    page: OverlaysPage(),
  ),
  _CatalogEntry(
    title: 'Media',
    subtitle: 'Network · progressive · masonry',
    icon: Icons.image_outlined,
    page: MediaPage(),
  ),
];

class _CatalogHome extends StatelessWidget {
  const _CatalogHome({required this.mode, required this.onToggleTheme});
  final ThemeMode mode;
  final VoidCallback onToggleTheme;

  IconData get _modeIcon => switch (mode) {
        ThemeMode.system => Icons.brightness_auto_outlined,
        ThemeMode.light => Icons.light_mode_outlined,
        ThemeMode.dark => Icons.dark_mode_outlined,
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: WlmAppBar(
        title: 'Wolwoloom',
        actions: [
          WlmHeaderIconButton(
            icon: _modeIcon,
            tooltip: 'Theme: ${mode.name}',
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(
            WlmTokens.spaceLg,
            WlmTokens.spaceMd,
            WlmTokens.spaceLg,
            WlmTokens.spaceXxl,
          ),
          children: [
            const WlmPageHeader(
              eyebrow: 'design system',
              title: 'Editorial Flutter\nfor mono lovers',
              subtitle: '60+ components · ink-on-paper · MIT',
            ),
            const SizedBox(height: WlmTokens.spaceLg),
            Row(
              children: const [
                Expanded(
                  child: WlmStat(
                    label: 'Components',
                    value: '60+',
                    trend: '+30 in v0.2',
                    trendPositive: true,
                  ),
                ),
                SizedBox(width: WlmTokens.spaceMd),
                Expanded(
                  child: WlmStat(label: 'Tokens', value: '24'),
                ),
                SizedBox(width: WlmTokens.spaceMd),
                Expanded(
                  child: WlmStat(label: 'License', value: 'MIT'),
                ),
              ],
            ),
            const SizedBox(height: WlmTokens.spaceXl),
            const WlmSectionLabel('Catalog'),
            const SizedBox(height: WlmTokens.spaceMd),
            for (final entry in _entries) ...[
              _CategoryTile(entry: entry),
              const SizedBox(height: WlmTokens.spaceMd),
            ],
            const SizedBox(height: WlmTokens.spaceLg),
            Center(
              child: Text(
                'wolwoloom · v0.2.0',
                style: WlmType.tiny(scheme.outline),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.entry});
  final _CatalogEntry entry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return WlmCard(
      child: InkWell(
        borderRadius: BorderRadius.circular(WlmTokens.radMd),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => entry.page,
            settings: RouteSettings(name: entry.title),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(WlmTokens.spaceMd),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: scheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(WlmTokens.radSm),
                  border: WlmTokens.hairlineBorder(scheme),
                ),
                alignment: Alignment.center,
                child: Icon(entry.icon, size: 18, color: scheme.onSurface),
              ),
              const SizedBox(width: WlmTokens.spaceMd),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(entry.title, style: WlmType.h3(scheme.onSurface)),
                    const SizedBox(height: 2),
                    Text(entry.subtitle, style: WlmType.meta(scheme.outline)),
                  ],
                ),
              ),
              Icon(
                Icons.chevron_right_rounded,
                color: scheme.outline,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
