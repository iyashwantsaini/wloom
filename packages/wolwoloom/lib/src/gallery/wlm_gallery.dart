import 'package:flutter/material.dart';

import '../../wolwoloom.dart';

/// In-package gallery / showcase. Drop this into any app to browse
/// every wloom component in one place — doubles as the package's
/// living reference and copy-paste source.
///
/// ```dart
/// import 'package:wolwoloom/gallery.dart';
///
/// MaterialApp(
///   theme: WlmTheme.light(),
///   darkTheme: WlmTheme.dark(),
///   home: const WlmGallery(),
/// );
/// ```
class WlmGallery extends StatefulWidget {
  const WlmGallery({super.key});

  @override
  State<WlmGallery> createState() => _WlmGalleryState();
}

class _WlmGalleryState extends State<WlmGallery> {
  static final List<_GallerySection> _sections = [
    _GallerySection('FOUNDATIONS', _ColorsDemo.new, _TypographyDemo.new,
        _SpacingDemo.new, _ElevationDemo.new, _MotionDemo.new),
    _GallerySection('BUTTONS', _ButtonsDemo.new),
    _GallerySection('INPUTS', _InputsDemo.new, _SegmentedDemo.new),
    _GallerySection('DISPLAY', _ChipsDemo.new, _BadgesDemo.new, _AvatarsDemo.new),
    _GallerySection('FEEDBACK', _LoadersDemo.new, _EmptyStateDemo.new,
        _SnackBarDemo.new, _RefreshDemo.new),
    _GallerySection('OVERLAYS', _DialogDemo.new, _SheetDemo.new),
    _GallerySection('NAVIGATION', _BottomNavDemo.new, _TabBarDemo.new),
    _GallerySection('MEDIA', _ImageDemo.new),
    _GallerySection('ICONS', _IconsDemo.new),
  ];

  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final wide = MediaQuery.of(context).size.width >= 720;

    final demos = _sections[_selected];

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: Text(
          'WLOOM // GALLERY',
          style: WlmType.label(scheme.onSurface).copyWith(letterSpacing: 1.6),
        ),
        backgroundColor: scheme.surface,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: WlmTokens.hairline,
            color: scheme.outlineVariant.withValues(alpha: 0.30),
          ),
        ),
      ),
      body: Row(
        children: [
          if (wide)
            SizedBox(
              width: 220,
              child: _Sidebar(
                sections: _sections,
                selected: _selected,
                onSelect: (i) => setState(() => _selected = i),
              ),
            )
          else
            const SizedBox.shrink(),
          if (wide)
            Container(
              width: WlmTokens.hairline,
              color: scheme.outlineVariant.withValues(alpha: 0.30),
            ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(WlmTokens.gutter),
              children: [
                Text(demos.title,
                    style: WlmType.h1(scheme.onSurface)),
                const SizedBox(height: WlmTokens.spaceXl),
                for (final builder in demos.demos) ...[
                  builder(),
                  const SizedBox(height: WlmTokens.section),
                ],
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: wide
          ? null
          : WlmBottomNav(
              currentIndex: _selected.clamp(0, 4),
              onTap: (i) => setState(() => _selected = i),
              items: [
                for (final s in _sections.take(5))
                  WlmNavItem(icon: WlmIcons.tag, label: s.title),
              ],
            ),
    );
  }
}

class _GallerySection {
  _GallerySection(this.title, [
    Widget Function()? d1,
    Widget Function()? d2,
    Widget Function()? d3,
    Widget Function()? d4,
    Widget Function()? d5,
  ]) : demos = [d1, d2, d3, d4, d5].whereType<Widget Function()>().toList();
  final String title;
  final List<Widget Function()> demos;
}

class _Sidebar extends StatelessWidget {
  const _Sidebar({
    required this.sections,
    required this.selected,
    required this.onSelect,
  });
  final List<_GallerySection> sections;
  final int selected;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: WlmTokens.spaceLg),
      itemCount: sections.length,
      itemBuilder: (_, i) {
        final s = sections[i];
        final isSel = i == selected;
        return InkWell(
          onTap: () => onSelect(i),
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: WlmTokens.spaceLg,
              vertical: WlmTokens.spaceMd,
            ),
            decoration: BoxDecoration(
              border: Border(
                left: BorderSide(
                  color: isSel ? scheme.onSurface : Colors.transparent,
                  width: 2,
                ),
              ),
            ),
            child: Text(
              s.title,
              style: WlmType.label(
                isSel ? scheme.onSurface : scheme.outline,
              ).copyWith(letterSpacing: 1.4),
            ),
          ),
        );
      },
    );
  }
}

// ── Reusable demo card ────────────────────────────────────────────────
class _DemoCard extends StatelessWidget {
  const _DemoCard({required this.title, required this.child});
  final String title;
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.all(WlmTokens.cardPadding),
      decoration: BoxDecoration(
        color: scheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(WlmTokens.radMd),
        border: WlmTokens.hairlineBorder(scheme),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(),
              style: WlmType.label(scheme.outline).copyWith(letterSpacing: 1.4)),
          const SizedBox(height: WlmTokens.spaceLg),
          child,
        ],
      ),
    );
  }
}

// ── Foundation demos ──────────────────────────────────────────────────
class _ColorsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final wlm = WlmTheme.of(context);
    final entries = <(String, Color)>[
      ('accent', wlm.accent),
      ('muted', wlm.muted),
      ('hairline', wlm.hairline),
      ('success', wlm.success),
      ('warning', wlm.warning),
      ('danger', wlm.danger),
      ('info', wlm.info),
    ];
    return _DemoCard(
      title: 'Semantic colors',
      child: Wrap(
        spacing: WlmTokens.spaceMd,
        runSpacing: WlmTokens.spaceMd,
        children: [
          for (final (name, color) in entries)
            Column(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(WlmTokens.radSm),
                    border: WlmTokens.hairlineBorder(
                        Theme.of(context).colorScheme),
                  ),
                ),
                const SizedBox(height: WlmTokens.spaceXs),
                Text(name,
                    style: WlmType.tiny(Theme.of(context).colorScheme.outline)),
              ],
            ),
        ],
      ),
    );
  }
}

class _TypographyDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final c = Theme.of(context).colorScheme.onSurface;
    return _DemoCard(
      title: 'Type scale',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Display', style: WlmType.display(c)),
          Text('H1 — page title', style: WlmType.h1(c)),
          Text('H2 — section', style: WlmType.h2(c)),
          Text('H3 — subsection', style: WlmType.h3(c)),
          Text('Body text', style: WlmType.body(c)),
          Text('Body small', style: WlmType.bodySmall(c)),
          Text('LABEL', style: WlmType.label(c)),
          Text('meta text', style: WlmType.meta(c)),
          Text('tiny', style: WlmType.tiny(c)),
        ],
      ),
    );
  }
}

class _SpacingDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final sizes = <(String, double)>[
      ('xs', WlmTokens.spaceXs),
      ('sm', WlmTokens.spaceSm),
      ('md', WlmTokens.spaceMd),
      ('lg', WlmTokens.spaceLg),
      ('xl', WlmTokens.spaceXl),
      ('xxl', WlmTokens.spaceXxl),
    ];
    return _DemoCard(
      title: 'Spacing scale',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, v) in sizes)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  SizedBox(
                      width: 36,
                      child: Text(name,
                          style: WlmType.tiny(scheme.outline))),
                  Container(
                      width: v, height: 12, color: scheme.onSurface),
                  const SizedBox(width: WlmTokens.spaceSm),
                  Text('${v.toInt()}px',
                      style: WlmType.tiny(scheme.outline)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ElevationDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    Widget box(String label, List<BoxShadow> shadows) => Container(
          width: 96,
          height: 64,
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(WlmTokens.radMd),
            border: WlmTokens.hairlineBorder(scheme),
            boxShadow: shadows,
          ),
          alignment: Alignment.center,
          child: Text(label, style: WlmType.tiny(scheme.outline)),
        );
    return _DemoCard(
      title: 'Elevation scale',
      child: Wrap(
        spacing: WlmTokens.spaceLg,
        runSpacing: WlmTokens.spaceLg,
        children: [
          box('SM', WlmTokens.shadowSm(scheme)),
          box('MD', WlmTokens.shadowMd(scheme)),
          box('LG', WlmTokens.shadowLg(scheme)),
        ],
      ),
    );
  }
}

class _MotionDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final rows = <(String, Duration)>[
      ('FAST', WlmMotion.fast),
      ('MEDIUM', WlmMotion.medium),
      ('SLOW', WlmMotion.slow),
    ];
    return _DemoCard(
      title: 'Motion tokens',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final (name, d) in rows)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Text('$name — ${d.inMilliseconds}ms',
                  style: WlmType.bodySmall(scheme.onSurface)),
            ),
          const SizedBox(height: WlmTokens.spaceSm),
          Text('Standard curve: easeOutCubic',
              style: WlmType.tiny(scheme.outline)),
          Text('Emphasized: easeOutQuart',
              style: WlmType.tiny(scheme.outline)),
        ],
      ),
    );
  }
}

// ── Component demos ───────────────────────────────────────────────────
class _ButtonsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Buttons',
      child: Wrap(
        spacing: WlmTokens.spaceMd,
        runSpacing: WlmTokens.spaceMd,
        children: [
          WlmPrimaryButton(label: 'PRIMARY', onPressed: () {}),
          WlmSecondaryButton(label: 'SECONDARY', onPressed: () {}),
          WlmGhostButton(label: 'GHOST', onPressed: () {}),
          WlmIconButton(icon: WlmIcons.settings, onPressed: () {}),
        ],
      ),
    );
  }
}

class _InputsDemo extends StatefulWidget {
  @override
  State<_InputsDemo> createState() => _InputsDemoState();
}

class _InputsDemoState extends State<_InputsDemo> {
  bool _check = true;
  bool _switch = false;
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Inputs',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const WlmTextField(label: 'NAME', hintText: 'jane.doe'),
          const SizedBox(height: WlmTokens.spaceMd),
          const WlmSearchField(hintText: 'Search'),
          const SizedBox(height: WlmTokens.spaceMd),
          Row(children: [
            WlmCheckbox(value: _check, onChanged: (v) => setState(() => _check = v)),
            const SizedBox(width: WlmTokens.spaceSm),
            const Text('Checkbox'),
            const SizedBox(width: WlmTokens.spaceLg),
            Switch(value: _switch, onChanged: (v) => setState(() => _switch = v)),
            const SizedBox(width: WlmTokens.spaceSm),
            const Text('Switch'),
          ]),
        ],
      ),
    );
  }
}

class _SegmentedDemo extends StatefulWidget {
  @override
  State<_SegmentedDemo> createState() => _SegmentedDemoState();
}

class _SegmentedDemoState extends State<_SegmentedDemo> {
  String _v = 'ALL';
  String _t = 'ALL';
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Segmented control',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          WlmSegmentedControl<String>(
            segments: const [
              WlmSegment(value: 'ALL', label: 'All', icon: Icons.dashboard_outlined),
              WlmSegment(value: 'IMG', label: 'Photos', icon: Icons.image_outlined),
              WlmSegment(value: 'VID', label: 'Videos', icon: Icons.videocam_outlined),
            ],
            value: _v,
            onChanged: (v) => setState(() => _v = v),
            expand: true,
          ),
          const SizedBox(height: WlmTokens.spaceLg),
          WlmSegmentedControl.text(
            segments: const ['ALL', 'PHOTOS', 'VIDEOS'],
            value: _t,
            onChanged: (v) => setState(() => _t = v),
          ),
        ],
      ),
    );
  }
}

class _ChipsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Chips & pills',
      child: Wrap(
        spacing: WlmTokens.spaceSm,
        runSpacing: WlmTokens.spaceSm,
        children: const [
          WlmChip(label: 'NATURE'),
          WlmChip(label: 'CITY', selected: true),
          WlmPill(label: '4K'),
          WlmTag(label: 'beta'),
        ],
      ),
    );
  }
}

class _BadgesDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Badges',
      child: Wrap(spacing: WlmTokens.spaceMd, children: const [
        WlmBadge(label: 'NEW'),
        WlmBadge(label: 'BETA'),
        WlmBadge(label: '12'),
      ]),
    );
  }
}

class _AvatarsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Avatars',
      child: Wrap(spacing: WlmTokens.spaceSm, children: const [
        WlmAvatar(initials: 'YS'),
        WlmAvatar(initials: 'JD'),
        WlmAvatar(initials: 'KL'),
      ]),
    );
  }
}

class _LoadersDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Loaders',
      child: Row(
        children: const [
          WlmLoader(),
          SizedBox(width: WlmTokens.spaceXl),
          Expanded(child: WlmScanBar(label: 'LOADING MORE')),
        ],
      ),
    );
  }
}

class _EmptyStateDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Empty state',
      child: WlmEmptyState(
        eyebrow: 'NO RESULTS',
        title: 'Nothing here yet.',
        body: 'Try a different filter or check back later.',
        icon: WlmIcons.search,
        action: WlmPrimaryButton(label: 'RETRY', onPressed: () {}),
        secondaryAction: WlmGhostButton(label: 'CLEAR FILTERS', onPressed: () {}),
      ),
    );
  }
}

class _SnackBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Snackbar',
      child: Wrap(
        spacing: WlmTokens.spaceMd,
        children: [
          WlmSecondaryButton(
            label: 'INFO',
            onPressed: () => WlmSnack.show(context, 'Saved.'),
          ),
          WlmSecondaryButton(
            label: 'WITH ACTION',
            onPressed: () => WlmSnack.show(context, 'Synced',
                actionLabel: 'UNDO', onAction: () {}),
          ),
        ],
      ),
    );
  }
}

class _RefreshDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Pull to refresh',
      child: SizedBox(
        height: 200,
        child: WlmRefresh(
          onRefresh: () => Future.delayed(const Duration(seconds: 2)),
          child: ListView(
            children: List.generate(
              20,
              (i) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Text('Row $i',
                    style: WlmType.body(
                        Theme.of(context).colorScheme.onSurface)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DialogDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Dialog',
      child: WlmPrimaryButton(
        label: 'OPEN DIALOG',
        onPressed: () => WlmDialog.confirm(
          context,
          title: 'CONFIRM',
          body: 'Delete this favorite?',
          confirmLabel: 'DELETE',
          cancelLabel: 'CANCEL',
          destructive: true,
        ),
      ),
    );
  }
}

class _SheetDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Bottom sheet',
      child: WlmPrimaryButton(
        label: 'OPEN SHEET',
        onPressed: () => showWlmBottomSheet(
          context: context,
          builder: (_) => Padding(
            padding: const EdgeInsets.all(WlmTokens.cardPadding),
            child: Text('Mono bottom sheet content',
                style: WlmType.body(Theme.of(context).colorScheme.onSurface)),
          ),
        ),
      ),
    );
  }
}

class _BottomNavDemo extends StatefulWidget {
  @override
  State<_BottomNavDemo> createState() => _BottomNavDemoState();
}

class _BottomNavDemoState extends State<_BottomNavDemo> {
  int _i = 0;
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Bottom nav (compact + full)',
      child: Column(
        children: [
          WlmBottomNav(
            currentIndex: _i,
            onTap: (v) => setState(() => _i = v),
            items: const [
              WlmNavItem(icon: WlmIcons.home, label: 'HOME'),
              WlmNavItem(icon: WlmIcons.search, label: 'SEARCH'),
              WlmNavItem(icon: WlmIcons.favoriteOutline, label: 'SAVED'),
              WlmNavItem(icon: WlmIcons.settings, label: 'SETTINGS'),
            ],
          ),
          const SizedBox(height: WlmTokens.spaceLg),
          WlmBottomNav(
            currentIndex: _i,
            compact: true,
            onTap: (v) => setState(() => _i = v),
            items: const [
              WlmNavItem(icon: WlmIcons.home, label: 'HOME'),
              WlmNavItem(icon: WlmIcons.search, label: 'SEARCH'),
              WlmNavItem(icon: WlmIcons.favoriteOutline, label: 'SAVED'),
              WlmNavItem(icon: WlmIcons.settings, label: 'SETTINGS'),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Tab bar',
      child: WlmTabBar(
        tabs: const [
          WlmTab(label: 'ALL'),
          WlmTab(label: 'NEW'),
          WlmTab(label: 'POPULAR'),
        ],
        currentIndex: 0,
        onTap: (_) {},
      ),
    );
  }
}

class _ImageDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _DemoCard(
      title: 'Network image (with fallback)',
      child: SizedBox(
        height: 160,
        child: Row(
          children: const [
            Expanded(
              child: WlmNetworkImage(
                url: 'https://picsum.photos/id/237/400/400',
              ),
            ),
            SizedBox(width: WlmTokens.spaceMd),
            Expanded(
              child: WlmNetworkImage(
                url: 'https://invalid-host.example/missing.jpg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _IconsDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final entries = <(String, IconData)>[
      ('home', WlmIcons.home),
      ('search', WlmIcons.search),
      ('filter', WlmIcons.filter),
      ('settings', WlmIcons.settings),
      ('favoriteOutline', WlmIcons.favoriteOutline),
      ('favorite', WlmIcons.favorite),
      ('bookmarkOutline', WlmIcons.bookmarkOutline),
      ('share', WlmIcons.share),
      ('download', WlmIcons.download),
      ('refresh', WlmIcons.refresh),
      ('info', WlmIcons.info),
      ('warning', WlmIcons.warning),
      ('error', WlmIcons.error),
      ('user', WlmIcons.user),
      ('key', WlmIcons.key),
      ('lock', WlmIcons.lock),
      ('light', WlmIcons.light),
      ('dark', WlmIcons.dark),
    ];
    return _DemoCard(
      title: 'WlmIcons (curated)',
      child: Wrap(
        spacing: WlmTokens.spaceLg,
        runSpacing: WlmTokens.spaceLg,
        children: [
          for (final (name, icon) in entries)
            SizedBox(
              width: 84,
              child: Column(
                children: [
                  Icon(icon, color: scheme.onSurface),
                  const SizedBox(height: WlmTokens.spaceXs),
                  Text(name,
                      style: WlmType.tiny(scheme.outline),
                      textAlign: TextAlign.center),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
