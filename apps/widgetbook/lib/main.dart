import 'package:flutter/material.dart';
import 'package:widgetbook/widgetbook.dart';
import 'package:wolwoloom/wolwoloom.dart';

void main() => runApp(const WidgetbookApp());

class WidgetbookApp extends StatelessWidget {
  const WidgetbookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Widgetbook.material(
      addons: [
        MaterialThemeAddon(
          themes: [
            WidgetbookTheme(name: 'Light', data: WlmTheme.light()),
            WidgetbookTheme(name: 'Dark', data: WlmTheme.dark()),
          ],
        ),
        ViewportAddon(const [
          IosViewports.iPhone13,
          AndroidViewports.samsungGalaxyS20,
          IosViewports.iPadPro11Inches,
        ]),
        TextScaleAddon(min: 0.85, max: 1.3),
        AlignmentAddon(),
      ],
      directories: [
        WidgetbookCategory(
          name: 'Foundations',
          children: [
            WidgetbookComponent(
              name: 'Tokens',
              useCases: [
                WidgetbookUseCase(name: 'Spacing', builder: _spacingTokens),
                WidgetbookUseCase(name: 'Radii', builder: _radiusTokens),
              ],
            ),
            WidgetbookComponent(
              name: 'Typography',
              useCases: [WidgetbookUseCase(name: 'All styles', builder: _typography)],
            ),
            WidgetbookComponent(
              name: 'Palette',
              useCases: [WidgetbookUseCase(name: 'Scheme swatches', builder: _palette)],
            ),
          ],
        ),
        WidgetbookCategory(
          name: 'Buttons',
          children: [
            _component('Primary', (ctx) => WlmPrimaryButton(
              label: ctx.knobs.string(label: 'Label', initialValue: 'Continue'),
              icon: ctx.knobs.boolean(label: 'Has icon') ? Icons.arrow_forward_rounded : null,
              expand: ctx.knobs.boolean(label: 'Expand'),
              onPressed: ctx.knobs.boolean(label: 'Enabled', initialValue: true) ? () {} : null,
            )),
            _component('Secondary', (ctx) => WlmSecondaryButton(
              label: ctx.knobs.string(label: 'Label', initialValue: 'Skip'),
              onPressed: () {},
            )),
            _component('Ghost', (ctx) => WlmGhostButton(
              label: ctx.knobs.string(label: 'Label', initialValue: 'Back'),
              icon: Icons.arrow_back_rounded,
              onPressed: () {},
            )),
            _component('Icon', (ctx) => WlmIconButton(
              icon: Icons.favorite_border,
              outlined: ctx.knobs.boolean(label: 'Outlined', initialValue: true),
              onPressed: () {},
            )),
            _component('Header icon', (ctx) => WlmHeaderIconButton(
              icon: Icons.tune_rounded,
              tooltip: 'Filters',
              badge: ctx.knobs.boolean(label: 'Badge'),
              onPressed: () {},
            )),
            _component('FAB', (ctx) => WlmFab(
              icon: Icons.add_rounded,
              label: ctx.knobs.boolean(label: 'Extended', initialValue: true) ? 'COMPOSE' : null,
              onPressed: () {},
            )),
          ],
        ),
        WidgetbookCategory(
          name: 'Inputs',
          children: [
            _component('Text field', (ctx) => SizedBox(
              width: 320,
              child: WlmTextField(
                label: ctx.knobs.string(label: 'Label', initialValue: 'Email'),
                hintText: 'you@domain.com',
                helperText: ctx.knobs.string(label: 'Helper', initialValue: 'We never share this.'),
                errorText: ctx.knobs.boolean(label: 'Error') ? 'Required' : null,
                prefixIcon: Icons.alternate_email,
              ),
            )),
            _component('Search field', (ctx) => const SizedBox(
              width: 320,
              child: WlmSearchField(),
            )),
            _component('Key field', (ctx) => SizedBox(
              width: 360,
              child: WlmKeyField(
                label: ctx.knobs.string(label: 'Label', initialValue: 'Wallhaven'),
                hintText: 'paste your key',
                onGetKey: () {},
              ),
            )),
            _component('Checkbox', (ctx) => _CheckboxDemo(initial: ctx.knobs.boolean(label: 'Initial', initialValue: true))),
            _component('Radio group', (_) => const _RadioDemo()),
            _component('Segmented', (_) => const _SegmentedDemo()),
            _component('Dropdown', (_) => const _DropdownDemo()),
            _component('Slider', (_) => const _SliderDemo()),
            _component('Stepper', (_) => const _StepperDemo()),
            _component('Date field', (_) => const _DateFieldDemo()),
            _component('Rating', (_) => const _RatingDemo()),
          ],
        ),
        WidgetbookCategory(
          name: 'Display',
          children: [
            _component('Badge', (ctx) => WlmBadge(
              label: ctx.knobs.string(label: 'Label', initialValue: 'Beta'),
            )),
            _component('Pill', (ctx) => WlmPill(
              label: ctx.knobs.string(label: 'Label', initialValue: 'WH'),
            )),
            _component('Chip', (ctx) => WlmChip(
              label: ctx.knobs.string(label: 'Label', initialValue: 'Nature'),
              filled: ctx.knobs.boolean(label: 'Filled'),
              selected: ctx.knobs.boolean(label: 'Selected'),
              onTap: () {},
            )),
            _component('Spec row', (ctx) => SizedBox(
              width: 320,
              child: WlmSpecRow(
                label: ctx.knobs.string(label: 'Label', initialValue: 'Sources'),
                value: ctx.knobs.string(label: 'Value', initialValue: 'WALLHAVEN · REDDIT · NASA'),
              ),
            )),
            _component('Divider', (_) => const SizedBox(width: 320, child: WlmDivider())),
            _component('Avatar', (ctx) => WlmAvatar(
              initials: ctx.knobs.string(label: 'Initials', initialValue: 'YS'),
              size: ctx.knobs.double.slider(label: 'Size', initialValue: 40, min: 24, max: 96),
              shape: ctx.knobs.boolean(label: 'Circle') ? WlmAvatarShape.circle : WlmAvatarShape.square,
            )),
            _component('Avatar stack', (_) => WlmAvatarStack(
              avatars: const [
                WlmAvatar(initials: 'YS'),
                WlmAvatar(initials: 'AC'),
                WlmAvatar(initials: 'JD'),
                WlmAvatar(initials: 'MK'),
                WlmAvatar(initials: 'RT'),
                WlmAvatar(initials: 'BL'),
              ],
            )),
            _component('Tag', (ctx) => WlmTag(
              label: ctx.knobs.string(label: 'Label', initialValue: 'wallpaper'),
              onRemove: ctx.knobs.boolean(label: 'Removable', initialValue: true) ? () {} : null,
            )),
            _component('Kbd', (ctx) => Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                WlmKbd(ctx.knobs.string(label: 'Key 1', initialValue: 'Ctrl')),
                const SizedBox(width: 4),
                const WlmKbd('+'),
                const SizedBox(width: 4),
                WlmKbd(ctx.knobs.string(label: 'Key 2', initialValue: 'K')),
              ],
            )),
            _component('Stat', (ctx) => SizedBox(
              width: 200,
              child: WlmStat(
                label: ctx.knobs.string(label: 'Label', initialValue: 'Downloads'),
                value: ctx.knobs.string(label: 'Value', initialValue: '12,403'),
                trend: '+12.4%',
                trendPositive: true,
              ),
            )),
            _component('Callout', (ctx) => SizedBox(
              width: 360,
              child: WlmCallout(
                title: 'Heads up',
                body: ctx.knobs.string(label: 'Body', initialValue: 'You can theme this in any of four tones.'),
                tone: ctx.knobs.object.dropdown(
                  label: 'Tone',
                  options: WlmCalloutTone.values,
                  initialOption: WlmCalloutTone.info,
                ),
              ),
            )),
            _component('Code block', (_) => const SizedBox(
              width: 420,
              child: WlmCodeBlock(
                language: 'dart',
                code: "final theme = WlmTheme.dark();\nrunApp(MaterialApp(theme: theme));",
              ),
            )),
            _component('Progress bar', (ctx) => SizedBox(
              width: 280,
              child: WlmProgressBar(
                label: 'UPLOADING',
                value: ctx.knobs.double.slider(label: 'Value', initialValue: 0.6, min: 0, max: 1),
              ),
            )),
            _component('Progress ring', (ctx) => WlmProgressRing(
              value: ctx.knobs.boolean(label: 'Determinate', initialValue: true)
                  ? ctx.knobs.double.slider(label: 'Value', initialValue: 0.6, min: 0, max: 1)
                  : null,
            )),
            _component('Tooltip', (_) => const WlmTooltip(
              message: 'Saved to favourites',
              child: Padding(
                padding: EdgeInsets.all(WlmTokens.spaceMd),
                child: Icon(Icons.bookmark_rounded),
              ),
            )),
          ],
        ),
        WidgetbookCategory(
          name: 'Layout',
          children: [
            _component('Card', (ctx) => SizedBox(
              width: 320,
              child: WlmCard(
                elevated: ctx.knobs.boolean(label: 'Elevated'),
                child: const Text('Card body'),
              ),
            )),
            _component('Page header', (ctx) => SizedBox(
              width: 360,
              child: WlmPageHeader(
                eyebrow: ctx.knobs.string(label: 'Eyebrow', initialValue: 'design system'),
                title: ctx.knobs.string(label: 'Title', initialValue: 'Wolwoloom'),
                subtitle: ctx.knobs.string(label: 'Subtitle', initialValue: '30+ components'),
                actions: [
                  WlmHeaderIconButton(icon: Icons.search_rounded, onPressed: () {}),
                  WlmHeaderIconButton(icon: Icons.tune_rounded, badge: true, onPressed: () {}),
                ],
              ),
            )),
            _component('Section label', (ctx) => SizedBox(
              width: 320,
              child: WlmSectionLabel(ctx.knobs.string(label: 'Text', initialValue: 'Recent')),
            )),
            _component('App bar', (ctx) => SizedBox(
              width: 360,
              child: WlmAppBar(
                title: ctx.knobs.string(label: 'Title', initialValue: 'Wolwoloom'),
                actions: [
                  WlmHeaderIconButton(icon: Icons.search_rounded, onPressed: () {}),
                ],
                showDivider: ctx.knobs.boolean(label: 'Divider', initialValue: true),
              ),
            )),
            _component('Accordion', (ctx) => SizedBox(
              width: 360,
              child: WlmAccordion(
                title: 'Pricing',
                subtitle: 'How is this priced?',
                child: Text(
                  'Wolwoloom is MIT-licensed and free forever.',
                  style: WlmType.bodySmall(Theme.of(ctx).colorScheme.onSurfaceVariant),
                ),
              ),
            )),
            _component('Breadcrumbs', (_) => WlmBreadcrumbs(
              crumbs: [
                WlmCrumb('Home', onTap: () {}),
                WlmCrumb('Components', onTap: () {}),
                const WlmCrumb('Card'),
              ],
            )),
            _component('Drawer', (_) => SizedBox(
              width: 280,
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
            )),
          ],
        ),
        WidgetbookCategory(
          name: 'Lists',
          children: [
            _component('List tile', (ctx) => SizedBox(
              width: 360,
              child: WlmListTile(
                title: ctx.knobs.string(label: 'Title', initialValue: 'Wallhaven'),
                subtitle: 'Curated phone wallpapers',
                leading: const Icon(Icons.cloud_outlined),
                trailing: const Icon(Icons.chevron_right_rounded),
                onTap: () {},
              ),
            )),
            _component('Action row', (ctx) => SizedBox(
              width: 360,
              child: WlmActionRow(
                icon: Icons.share_outlined,
                label: ctx.knobs.string(label: 'Label', initialValue: 'Share link'),
                destructive: ctx.knobs.boolean(label: 'Destructive'),
                onTap: () {},
              ),
            )),
            _component('Switch tile', (ctx) => _SwitchTileDemo(initial: ctx.knobs.boolean(label: 'Initial value', initialValue: true))),
            _component('Checkbox tile', (_) => const _CheckboxTileDemo()),
            _component('Radio tile group', (_) => const _RadioTileGroupDemo()),
          ],
        ),
        WidgetbookCategory(
          name: 'Feedback',
          children: [
            _component('Loader', (ctx) => WlmLoader(
              label: ctx.knobs.string(label: 'Label', initialValue: 'LOADING'),
              size: ctx.knobs.double.slider(label: 'Size', initialValue: 48, min: 24, max: 96),
              compact: ctx.knobs.boolean(label: 'Compact'),
            )),
            _component('Scan bar', (ctx) => WlmScanBar(
              label: ctx.knobs.string(label: 'Label', initialValue: 'LOADING MORE'),
            )),
            _component('Skeleton', (ctx) => SizedBox(
              width: 220,
              child: WlmSkeleton(
                height: ctx.knobs.double.slider(label: 'Height', initialValue: 16, min: 8, max: 200),
              ),
            )),
            _component('Grid skeleton', (_) => const SizedBox(
              width: 320,
              height: 480,
              child: WlmGridSkeleton(),
            )),
            _component('Snackbar', (_) => Builder(builder: (context) => WlmPrimaryButton(
              label: 'Show',
              onPressed: () => WlmSnack.show(context, 'Saved', actionLabel: 'Undo'),
            ))),
            _component('Toast', (_) => Builder(builder: (context) => WlmPrimaryButton(
              label: 'Show toast',
              onPressed: () => WlmToast.show(context, 'Copied to clipboard', tone: WlmCalloutTone.success),
            ))),
            _component('Banner', (ctx) => SizedBox(
              width: 480,
              child: WlmBanner(
                title: 'Update available',
                message: 'A new version of Wolwoloom is ready.',
                actionLabel: 'Update',
                tone: ctx.knobs.object.dropdown(
                  label: 'Tone',
                  options: WlmCalloutTone.values,
                  initialOption: WlmCalloutTone.info,
                ),
                onAction: () {},
                onDismiss: () {},
              ),
            )),
            _component('Empty state', (_) => const SizedBox(
              width: 360,
              child: WlmEmptyState(
                icon: Icons.bookmark_border_rounded,
                title: 'Nothing saved yet',
                body: 'Tap the bookmark icon on any wallpaper to save it for later.',
              ),
            )),
            _component('Error state', (_) => SizedBox(
              width: 360,
              child: WlmErrorState(
                title: "We couldn't load that.",
                body: 'Check your connection and try again.',
                details: 'SocketException: Failed host lookup',
                onRetry: () {},
              ),
            )),
          ],
        ),
        WidgetbookCategory(
          name: 'Navigation',
          children: [
            _component('Bottom nav', (ctx) => _BottomNavDemo(
              index: ctx.knobs.int.slider(label: 'Index', initialValue: 0, min: 0, max: 3),
            )),
            _component('Step dots', (ctx) => SizedBox(
              width: 320,
              child: WlmStepDots(
                total: 4,
                index: ctx.knobs.int.slider(label: 'Index', initialValue: 1, min: 0, max: 3),
              ),
            )),
            _component('Tab bar', (_) => const _TabBarDemo()),
            _component('Shell', (_) => SizedBox(
              width: 360,
              height: 540,
              child: WlmShell(
                appBarTitle: 'Wolwoloom',
                items: const [
                  WlmNavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
                  WlmNavItem(icon: Icons.search_rounded, label: 'Search'),
                  WlmNavItem(icon: Icons.bookmark_outline, label: 'Saved'),
                ],
                builder: (ctx, i) => Center(
                  child: Text('Tab $i', style: WlmType.h1(Theme.of(ctx).colorScheme.onSurface)),
                ),
              ),
            )),
          ],
        ),
        WidgetbookCategory(
          name: 'Overlays',
          children: [
            _component('Bottom sheet', (_) => Builder(builder: (context) => WlmPrimaryButton(
              label: 'Open',
              onPressed: () => showWlmBottomSheet<void>(
                context: context,
                builder: (ctx) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const WlmSectionLabel('Quick actions'),
                    WlmActionRow(icon: Icons.share, label: 'Share', onTap: () => Navigator.pop(ctx)),
                    WlmActionRow(icon: Icons.delete_outline, label: 'Remove', destructive: true, onTap: () => Navigator.pop(ctx)),
                  ],
                ),
              ),
            ))),
            _component('Dialog', (_) => Builder(builder: (context) => WlmPrimaryButton(
              label: 'Open',
              onPressed: () => WlmDialog.show(
                context,
                title: 'Delete favourite?',
                body: 'This will remove the wallpaper from your on-device list.',
                confirmLabel: 'Delete',
                destructive: true,
              ),
            ))),
          ],
        ),
        WidgetbookCategory(
          name: 'Media',
          children: [
            _component('Network image', (_) => const SizedBox(
              width: 220,
              height: 320,
              child: WlmNetworkImage(
                url: 'https://picsum.photos/seed/wlm/400/600',
              ),
            )),
            _component('Progressive image', (_) => const SizedBox(
              width: 220,
              height: 320,
              child: WlmProgressiveImage(
                thumbUrl: 'https://picsum.photos/seed/wlm/40/60',
                hiResUrl: 'https://picsum.photos/seed/wlm/600/900',
              ),
            )),
          ],
        ),
      ],
    );
  }
}

WidgetbookComponent _component(String name, WidgetBuilder builder) =>
    WidgetbookComponent(
      name: name,
      useCases: [WidgetbookUseCase(name: 'Default', builder: builder)],
    );

// ── Foundation use cases ───────────────────────────────────────────

Widget _spacingTokens(BuildContext context) {
  const items = [
    ('xs (4)', WlmTokens.spaceXs),
    ('sm (8)', WlmTokens.spaceSm),
    ('md (12)', WlmTokens.spaceMd),
    ('lg (16)', WlmTokens.spaceLg),
    ('xl (24)', WlmTokens.spaceXl),
    ('xxl (32)', WlmTokens.spaceXxl),
  ];
  final scheme = Theme.of(context).colorScheme;
  return Padding(
    padding: const EdgeInsets.all(WlmTokens.spaceLg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final (label, value) in items) ...[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: WlmTokens.spaceSm),
            child: Row(
              children: [
                SizedBox(width: 96, child: Text(label, style: WlmType.label(scheme.outline))),
                Container(width: value, height: 16, color: scheme.onSurface),
              ],
            ),
          ),
        ],
      ],
    ),
  );
}

Widget _radiusTokens(BuildContext context) {
  const items = [
    ('sm', WlmTokens.radSm),
    ('md', WlmTokens.radMd),
    ('lg', WlmTokens.radLg),
    ('xl', WlmTokens.radXl),
  ];
  final scheme = Theme.of(context).colorScheme;
  return Wrap(
    spacing: WlmTokens.spaceLg,
    runSpacing: WlmTokens.spaceLg,
    children: [
      for (final (label, value) in items)
        Column(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: scheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(value),
                border: WlmTokens.hairlineBorder(scheme),
              ),
            ),
            const SizedBox(height: WlmTokens.spaceSm),
            Text(label.toUpperCase(), style: WlmType.label(scheme.outline)),
          ],
        ),
    ],
  );
}

Widget _typography(BuildContext context) {
  final scheme = Theme.of(context).colorScheme;
  final c = scheme.onSurface;
  return Padding(
    padding: const EdgeInsets.all(WlmTokens.spaceLg),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('Display', style: WlmType.display(c)),
        Text('Heading 1', style: WlmType.h1(c)),
        Text('Heading 2', style: WlmType.h2(c)),
        Text('Heading 3', style: WlmType.h3(c)),
        Text('Body', style: WlmType.body(c)),
        Text('Body small', style: WlmType.bodySmall(c)),
        Text('LABEL', style: WlmType.label(scheme.outline)),
        Text('Meta caption', style: WlmType.meta(scheme.outline)),
        Text('TINY', style: WlmType.tiny(scheme.outline)),
      ],
    ),
  );
}

Widget _palette(BuildContext context) {
  final s = Theme.of(context).colorScheme;
  final swatches = <(String, Color)>[
    ('surface', s.surface),
    ('surfaceContainerHighest', s.surfaceContainerHighest),
    ('onSurface', s.onSurface),
    ('outline', s.outline),
    ('outlineVariant', s.outlineVariant),
    ('primary', s.primary),
    ('secondary', s.secondary),
    ('error', s.error),
  ];
  return Padding(
    padding: const EdgeInsets.all(WlmTokens.spaceLg),
    child: Wrap(
      spacing: WlmTokens.spaceMd,
      runSpacing: WlmTokens.spaceMd,
      children: [
        for (final (name, color) in swatches)
          Column(
            children: [
              Container(
                width: 96,
                height: 96,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(WlmTokens.radMd),
                  border: WlmTokens.hairlineBorder(s),
                ),
              ),
              const SizedBox(height: WlmTokens.spaceSm),
              SizedBox(width: 96, child: Text(name, style: WlmType.tiny(s.onSurface), textAlign: TextAlign.center)),
            ],
          ),
      ],
    ),
  );
}

class _SwitchTileDemo extends StatefulWidget {
  const _SwitchTileDemo({required this.initial});
  final bool initial;
  @override
  State<_SwitchTileDemo> createState() => _SwitchTileDemoState();
}

class _SwitchTileDemoState extends State<_SwitchTileDemo> {
  late bool _v = widget.initial;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: WlmSwitchTile(
        title: 'Daily wallpaper',
        subtitle: 'Rotate a new wallpaper each morning',
        value: _v,
        onChanged: (v) => setState(() => _v = v),
      ),
    );
  }
}

class _BottomNavDemo extends StatelessWidget {
  const _BottomNavDemo({required this.index});
  final int index;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 360,
      child: WlmBottomNav(
        currentIndex: index,
        onTap: (_) {},
        items: const [
          WlmNavItem(icon: Icons.home_outlined, activeIcon: Icons.home, label: 'Home'),
          WlmNavItem(icon: Icons.search_rounded, label: 'Search'),
          WlmNavItem(icon: Icons.bookmark_outline, label: 'Saved'),
          WlmNavItem(icon: Icons.settings_outlined, label: 'Settings'),
        ],
      ),
    );
  }
}

// Phase 2 demos appended below

class _CheckboxDemo extends StatefulWidget {
  const _CheckboxDemo({required this.initial});
  final bool initial;
  @override
  State<_CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<_CheckboxDemo> {
  late bool _v = widget.initial;
  @override
  Widget build(BuildContext context) =>
      WlmCheckbox(value: _v, onChanged: (v) => setState(() => _v = v));
}

class _RadioDemo extends StatefulWidget {
  const _RadioDemo();
  @override
  State<_RadioDemo> createState() => _RadioDemoState();
}

class _RadioDemoState extends State<_RadioDemo> {
  String _v = 'a';
  @override
  Widget build(BuildContext context) {
    Widget row(String label, String value) => Padding(
          padding: const EdgeInsets.symmetric(vertical: WlmTokens.spaceXs),
          child: Row(
            children: [
              WlmRadio<String>(
                value: value,
                groupValue: _v,
                onChanged: (v) => setState(() => _v = v ?? _v),
              ),
              const SizedBox(width: WlmTokens.spaceMd),
              Text(label, style: WlmType.body(Theme.of(context).colorScheme.onSurface)),
            ],
          ),
        );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [row('Apple', 'a'), row('Banana', 'b'), row('Cherry', 'c')],
    );
  }
}

class _SegmentedDemo extends StatefulWidget {
  const _SegmentedDemo();
  @override
  State<_SegmentedDemo> createState() => _SegmentedDemoState();
}

class _SegmentedDemoState extends State<_SegmentedDemo> {
  int _v = 0;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 320,
        child: WlmSegmentedControl<int>(
          expand: true,
          value: _v,
          onChanged: (v) => setState(() => _v = v),
          segments: const [
            WlmSegment(value: 0, label: 'Daily', icon: Icons.today_rounded),
            WlmSegment(value: 1, label: 'Weekly'),
            WlmSegment(value: 2, label: 'Monthly'),
          ],
        ),
      );
}

class _DropdownDemo extends StatefulWidget {
  const _DropdownDemo();
  @override
  State<_DropdownDemo> createState() => _DropdownDemoState();
}

class _DropdownDemoState extends State<_DropdownDemo> {
  String? _v = 'wallhaven';
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 240,
        child: WlmDropdown<String>(
          label: 'Source',
          value: _v,
          onChanged: (v) => setState(() => _v = v),
          items: const [
            WlmDropdownItem(value: 'wallhaven', label: 'Wallhaven'),
            WlmDropdownItem(value: 'reddit', label: 'Reddit'),
            WlmDropdownItem(value: 'nasa', label: 'NASA'),
          ],
        ),
      );
}

class _SliderDemo extends StatefulWidget {
  const _SliderDemo();
  @override
  State<_SliderDemo> createState() => _SliderDemoState();
}

class _SliderDemoState extends State<_SliderDemo> {
  double _v = 0.4;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 320,
        child: WlmSlider(value: _v, onChanged: (v) => setState(() => _v = v)),
      );
}

class _StepperDemo extends StatefulWidget {
  const _StepperDemo();
  @override
  State<_StepperDemo> createState() => _StepperDemoState();
}

class _StepperDemoState extends State<_StepperDemo> {
  int _v = 1;
  @override
  Widget build(BuildContext context) => WlmStepper(
        label: 'Quantity',
        value: _v,
        onChanged: (v) => setState(() => _v = v),
      );
}

class _DateFieldDemo extends StatefulWidget {
  const _DateFieldDemo();
  @override
  State<_DateFieldDemo> createState() => _DateFieldDemoState();
}

class _DateFieldDemoState extends State<_DateFieldDemo> {
  DateTime? _v;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 280,
        child: WlmDateField(
          label: 'Birthday',
          value: _v,
          onChanged: (v) => setState(() => _v = v),
        ),
      );
}

class _RatingDemo extends StatefulWidget {
  const _RatingDemo();
  @override
  State<_RatingDemo> createState() => _RatingDemoState();
}

class _RatingDemoState extends State<_RatingDemo> {
  int _v = 3;
  @override
  Widget build(BuildContext context) =>
      WlmRating(value: _v, onChanged: (v) => setState(() => _v = v));
}

class _CheckboxTileDemo extends StatefulWidget {
  const _CheckboxTileDemo();
  @override
  State<_CheckboxTileDemo> createState() => _CheckboxTileDemoState();
}

class _CheckboxTileDemoState extends State<_CheckboxTileDemo> {
  bool _v = true;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 360,
        child: WlmCheckboxTile(
          title: 'Send weekly digest',
          subtitle: 'Curated wallpapers, every Sunday morning.',
          value: _v,
          onChanged: (v) => setState(() => _v = v),
        ),
      );
}

class _RadioTileGroupDemo extends StatefulWidget {
  const _RadioTileGroupDemo();
  @override
  State<_RadioTileGroupDemo> createState() => _RadioTileGroupDemoState();
}

class _RadioTileGroupDemoState extends State<_RadioTileGroupDemo> {
  String _v = 'system';
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 360,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final entry in const [
              ('system', 'System', 'Match the device theme'),
              ('light', 'Light', 'Always use the light scheme'),
              ('dark', 'Dark', 'Always use the dark scheme'),
            ])
              WlmRadioTile<String>(
                value: entry.$1,
                groupValue: _v,
                title: entry.$2,
                subtitle: entry.$3,
                onChanged: (v) => setState(() => _v = v ?? _v),
              ),
          ],
        ),
      );
}

class _TabBarDemo extends StatefulWidget {
  const _TabBarDemo();
  @override
  State<_TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<_TabBarDemo> {
  int _i = 0;
  @override
  Widget build(BuildContext context) => SizedBox(
        width: 360,
        child: WlmTabBar(
          currentIndex: _i,
          onTap: (i) => setState(() => _i = i),
          tabs: const [
            WlmTab(label: 'Curated'),
            WlmTab(label: 'Latest'),
            WlmTab(label: 'Favourites'),
          ],
        ),
      );
}
