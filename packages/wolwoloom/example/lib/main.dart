import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import 'pages/buttons_page.dart';
import 'pages/display_page.dart';
import 'pages/feedback_page.dart';
import 'pages/forms_page.dart';
import 'pages/foundations_page.dart';
import 'pages/inputs_page.dart';
import 'pages/layout_page.dart';
import 'pages/lists_page.dart';
import 'pages/media_page.dart';
import 'pages/navigation_page.dart';
import 'pages/overlays_page.dart';
import 'screens/chat_screen.dart';
import 'screens/dashboard_screen.dart';
import 'screens/login_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/settings_screen.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  ThemeMode _mode = _initialMode();

  static ThemeMode _initialMode() {
    // Allow `?theme=light|dark|system` in the URL — useful for screenshots.
    try {
      final v = Uri.base.queryParameters['theme'];
      return switch (v) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
    } catch (_) {
      return ThemeMode.system;
    }
  }

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
      title: 'wloom',
      theme: WlmTheme.light(),
      darkTheme: WlmTheme.dark(),
      themeMode: _mode,
      builder: (ctx, child) => WlmToaster(child: child ?? const SizedBox()),
      home: _initialScreen() ??
          _CatalogHome(mode: _mode, onToggleTheme: _toggle),
      debugShowCheckedModeBanner: false,
    );
  }

  /// `?screen=...` deep-link to a demo screen or `?page=...` to a category.
  Widget? _initialScreen() {
    try {
      final params = Uri.base.queryParameters;
      final s = params['screen'];
      final screen = switch (s) {
        'login' => const LoginScreen(),
        'onboarding' => const OnboardingScreen(),
        'dashboard' => const DashboardScreen(),
        'profile' => const ProfileScreen(),
        'settings' => const SettingsScreen(),
        'chat' => const ChatScreen(),
        _ => null,
      };
      if (screen != null) return screen;
      final p = params['page'];
      return switch (p) {
        'foundations' => const FoundationsPage(),
        'buttons' => const ButtonsPage(),
        'inputs' => const InputsPage(),
        'forms' => const FormsPage(),
        'display' => const DisplayPage(),
        'layout' => const LayoutPage(),
        'lists' => const ListsPage(),
        'feedback' => const FeedbackPage(),
        'navigation' => const NavigationPage(),
        'overlays' => const OverlaysPage(),
        'media' => const MediaPage(),
        _ => null,
      };
    } catch (_) {
      return null;
    }
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
    title: 'Forms',
    subtitle: 'Controller · fields · validators',
    icon: Icons.fact_check_outlined,
    page: FormsPage(),
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

const _templates = <_CatalogEntry>[
  _CatalogEntry(
    title: 'Login',
    subtitle: 'Auth form · social sign-in · checkbox',
    icon: Icons.login_rounded,
    page: LoginScreen(),
  ),
  _CatalogEntry(
    title: 'Onboarding',
    subtitle: '3-step carousel · step dots',
    icon: Icons.auto_stories_outlined,
    page: OnboardingScreen(),
  ),
  _CatalogEntry(
    title: 'Dashboard',
    subtitle: 'KPI cards · sparklines · timeline',
    icon: Icons.insights_outlined,
    page: DashboardScreen(),
  ),
  _CatalogEntry(
    title: 'Profile',
    subtitle: 'Avatar · stats · segmented tabs',
    icon: Icons.account_circle_outlined,
    page: ProfileScreen(),
  ),
  _CatalogEntry(
    title: 'Settings',
    subtitle: 'Switch tiles · action sheet · groups',
    icon: Icons.settings_outlined,
    page: SettingsScreen(),
  ),
  _CatalogEntry(
    title: 'Chat',
    subtitle: 'Message bubbles · composer · status',
    icon: Icons.forum_outlined,
    page: ChatScreen(),
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
        title: 'wloom',
        actions: [
          WlmHeaderIconButton(
            icon: Icons.code_rounded,
            tooltip: 'Source on GitHub',
            onPressed: () {},
          ),
          WlmHeaderIconButton(
            icon: _modeIcon,
            tooltip: 'Theme: ${mode.name}',
            onPressed: onToggleTheme,
          ),
        ],
      ),
      body: SafeArea(
        top: false,
        child: LayoutBuilder(
          builder: (context, c) {
            final wide = c.maxWidth >= 720;
            final maxW = c.maxWidth >= 1100 ? 1080.0 : c.maxWidth;
            return Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxW),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(
                    wide ? WlmTokens.spaceXxl : WlmTokens.spaceLg,
                    WlmTokens.spaceLg,
                    wide ? WlmTokens.spaceXxl : WlmTokens.spaceLg,
                    WlmTokens.spaceXxl,
                  ),
                  children: [
                    _Hero(wide: wide),
                    const SizedBox(height: WlmTokens.spaceXl),
                    const _StatStrip(),
                    const SizedBox(height: WlmTokens.spaceXl),
                    const WlmCallout(
                      tone: WlmCalloutTone.info,
                      title: 'New in v0.3.0',
                      body:
                          'Unified WlmButton (variant + size + loading) · '
                          'Toaster queue · Popover · Menu · Combobox · '
                          'PinInput · Toggle · DataTable · Pagination · '
                          'Form + validators · Command palette (⌘K).',
                    ),
                    const SizedBox(height: WlmTokens.spaceXl),
                    Row(
                      children: [
                        const WlmSectionLabel('Catalog'),
                        const Spacer(),
                        Text(
                          '${_entries.length} sections',
                          style: WlmType.tiny(scheme.outline),
                        ),
                      ],
                    ),
                    const SizedBox(height: WlmTokens.spaceMd),
                    _CategoryGrid(entries: _entries, wide: wide),
                    const SizedBox(height: WlmTokens.spaceXl),
                    Row(
                      children: [
                        const WlmSectionLabel('Templates'),
                        const Spacer(),
                        Text(
                          '${_templates.length} demo screens',
                          style: WlmType.tiny(scheme.outline),
                        ),
                      ],
                    ),
                    const SizedBox(height: WlmTokens.spaceMd),
                    _CategoryGrid(entries: _templates, wide: wide),
                    const SizedBox(height: WlmTokens.spaceXl),
                    const _Footer(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _Hero extends StatelessWidget {
  const _Hero({required this.wide});
  final bool wide;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final wlm = WlmThemeExtension.of(context);
    final titleStyle = (wide ? WlmType.h1(scheme.onSurface) : WlmType.h1(scheme.onSurface))
        .copyWith(
      fontSize: wide ? 56 : 38,
      height: 1.05,
      letterSpacing: -1.2,
    );
    return Container(
      padding: EdgeInsets.fromLTRB(
        WlmTokens.spaceLg,
        wide ? WlmTokens.spaceXxl : WlmTokens.spaceXl,
        WlmTokens.spaceLg,
        wide ? WlmTokens.spaceXxl : WlmTokens.spaceXl,
      ),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(WlmTokens.radLg),
        border: Border.all(color: wlm.hairline, width: WlmTokens.hairline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: WlmTokens.spaceSm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: wlm.hairline),
                  borderRadius: BorderRadius.circular(WlmTokens.radSm),
                ),
                child: Text(
                  'DESIGN SYSTEM · v0.3',
                  style: WlmType.tiny(scheme.outline),
                ),
              ),
              const SizedBox(width: WlmTokens.spaceSm),
              const WlmBadge(label: 'MIT'),
            ],
          ),
          const SizedBox(height: WlmTokens.spaceLg),
          Text('Editorial Flutter\nfor mono lovers.', style: titleStyle),
          const SizedBox(height: WlmTokens.spaceMd),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 560),
            child: Text(
              'A drop-in Material 3 design system with a typewriter soul. '
              'Hairline borders, ALL-CAPS micro-labels, JetBrains Mono '
              'across the entire surface — light and dark.',
              style: WlmType.body(scheme.onSurfaceVariant).copyWith(height: 1.5),
            ),
          ),
          const SizedBox(height: WlmTokens.spaceLg),
          Align(
            alignment: Alignment.centerLeft,
            child: Wrap(
              spacing: WlmTokens.spaceSm,
              runSpacing: WlmTokens.spaceSm,
              children: [
                WlmPrimaryButton(
                  label: 'GET STARTED',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: () {},
                ),
                WlmGhostButton(
                  label: 'GITHUB',
                  icon: Icons.code_rounded,
                  onPressed: () {},
                ),
                WlmGhostButton(
                  label: 'WIDGETBOOK',
                  icon: Icons.grid_view_rounded,
                  onPressed: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatStrip extends StatelessWidget {
  const _StatStrip();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, c) {
        final wlm = WlmThemeExtension.of(context);
        final tiles = const [
          WlmStat(
            label: 'Components',
            value: '74+',
            trend: '+14 in v0.3',
            trendPositive: true,
          ),
          WlmStat(label: 'Tokens', value: '24'),
          WlmStat(label: 'License', value: 'MIT'),
          WlmStat(label: 'Themes', value: 'LIGHT · DARK'),
        ];
        // Single bordered strip — tiles separated by a vertical hairline
        // when there's room, otherwise a 2-col grid that always reads
        // top-to-bottom, left-to-right with consistent left alignment.
        final wide = c.maxWidth >= 720;
        final mid = c.maxWidth >= 420;
        if (wide) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(WlmTokens.radLg),
              border: Border.all(
                color: wlm.hairline,
                width: WlmTokens.hairline,
              ),
            ),
            padding: const EdgeInsets.symmetric(
              horizontal: WlmTokens.spaceLg,
              vertical: WlmTokens.spaceLg,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  for (var i = 0; i < tiles.length; i++) ...[
                    if (i > 0)
                      Container(
                        width: WlmTokens.hairline,
                        margin: const EdgeInsets.symmetric(
                          horizontal: WlmTokens.spaceLg,
                        ),
                        color: wlm.hairline,
                      ),
                    Expanded(child: tiles[i]),
                  ],
                ],
              ),
            ),
          );
        }
        // 2-col grid for medium / narrow — every tile gets equal width
        // and is left-aligned via SizedBox(width: double.infinity).
        final cols = mid ? 2 : 2;
        final rows = (tiles.length / cols).ceil();
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(WlmTokens.radLg),
            border: Border.all(
              color: wlm.hairline,
              width: WlmTokens.hairline,
            ),
          ),
          padding: const EdgeInsets.all(WlmTokens.spaceLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (var r = 0; r < rows; r++) ...[
                if (r > 0) const SizedBox(height: WlmTokens.spaceLg),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      for (var col = 0; col < cols; col++) ...[
                        if (col > 0)
                          const SizedBox(width: WlmTokens.spaceLg),
                        Expanded(
                          child: r * cols + col < tiles.length
                              ? SizedBox(
                                  width: double.infinity,
                                  child: tiles[r * cols + col],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _CategoryGrid extends StatelessWidget {
  const _CategoryGrid({required this.entries, required this.wide});
  final List<_CatalogEntry> entries;
  final bool wide;

  @override
  Widget build(BuildContext context) {
    if (!wide) {
      return Column(
        children: [
          for (final e in entries) ...[
            _CategoryTile(entry: e),
            const SizedBox(height: WlmTokens.spaceSm),
          ],
        ],
      );
    }
    final rows = <Widget>[];
    for (var i = 0; i < entries.length; i += 2) {
      final left = entries[i];
      final right = i + 1 < entries.length ? entries[i + 1] : null;
      rows.add(
        Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: _CategoryTile(entry: left)),
            const SizedBox(width: WlmTokens.spaceMd),
            Expanded(
              child: right != null
                  ? _CategoryTile(entry: right)
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      );
      rows.add(const SizedBox(height: WlmTokens.spaceMd));
    }
    return Column(children: rows);
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({required this.entry});
  final _CatalogEntry entry;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final wlm = WlmThemeExtension.of(context);
    return Material(
      color: scheme.surface,
      borderRadius: BorderRadius.circular(WlmTokens.radMd),
      child: InkWell(
        borderRadius: BorderRadius.circular(WlmTokens.radMd),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (_) => entry.page,
            settings: RouteSettings(name: entry.title),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.all(WlmTokens.spaceLg),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(WlmTokens.radMd),
            border: Border.all(color: wlm.hairline, width: WlmTokens.hairline),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: scheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(WlmTokens.radSm),
                      border: Border.all(color: wlm.hairline),
                    ),
                    alignment: Alignment.center,
                    child: Icon(entry.icon, size: 18, color: scheme.onSurface),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.arrow_outward_rounded,
                    color: scheme.outline,
                    size: 16,
                  ),
                ],
              ),
              const SizedBox(height: WlmTokens.spaceMd),
              Text(
                entry.title.toUpperCase(),
                style: WlmType.h3(scheme.onSurface).copyWith(letterSpacing: 0.4),
              ),
              const SizedBox(height: 4),
              Text(
                entry.subtitle,
                style: WlmType.meta(scheme.outline),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final wlm = WlmThemeExtension.of(context);
    return Column(
      children: [
        Container(height: WlmTokens.hairline, color: wlm.hairline),
        const SizedBox(height: WlmTokens.spaceMd),
        Row(
          children: [
            Text(
              'wloom · v0.3.0',
              style: WlmType.tiny(scheme.outline),
            ),
            const Spacer(),
            Text(
              'MIT · ink-on-paper',
              style: WlmType.tiny(scheme.outline),
            ),
          ],
        ),
      ],
    );
  }
}
