import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

void main() => runApp(const ExampleApp());

class ExampleApp extends StatelessWidget {
  const ExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wolwoloom Example',
      theme: WlmTheme.light(),
      darkTheme: WlmTheme.dark(),
      themeMode: ThemeMode.system,
      home: const _Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class _Home extends StatefulWidget {
  const _Home();
  @override
  State<_Home> createState() => _HomeState();
}

class _HomeState extends State<_Home> {
  int _tab = 0;
  bool _switch = true;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            WlmPageHeader(
              eyebrow: 'design system',
              title: 'Wolwoloom',
              subtitle: '30+ components · mono · hairline · ink',
              actions: [
                WlmHeaderIconButton(
                  icon: Icons.search_rounded,
                  tooltip: 'Search',
                  onPressed: () {},
                ),
                WlmHeaderIconButton(
                  icon: Icons.tune_rounded,
                  tooltip: 'Filters',
                  badge: true,
                  onPressed: () {},
                ),
              ],
            ),
            const WlmSectionLabel('Buttons'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: WlmTokens.spaceLg),
              child: Wrap(
                spacing: WlmTokens.spaceSm,
                runSpacing: WlmTokens.spaceSm,
                children: [
                  WlmPrimaryButton(label: 'Continue', onPressed: () {}),
                  WlmSecondaryButton(label: 'Skip', onPressed: () {}),
                  WlmGhostButton(
                    label: 'Back',
                    icon: Icons.arrow_back_rounded,
                    onPressed: () {},
                  ),
                  WlmIconButton(
                    icon: Icons.favorite_border,
                    onPressed: () {},
                    outlined: true,
                  ),
                ],
              ),
            ),
            const WlmSectionLabel('Inputs'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: WlmTokens.spaceLg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const WlmSearchField(hintText: 'Search wallpapers'),
                  const SizedBox(height: WlmTokens.spaceMd),
                  const WlmTextField(
                    label: 'Email',
                    hintText: 'you@domain.com',
                    helperText: 'We never share this.',
                    prefixIcon: Icons.alternate_email,
                  ),
                  const SizedBox(height: WlmTokens.spaceMd),
                  WlmKeyField(
                    label: 'Wallhaven API key',
                    hintText: 'paste your key',
                    onGetKey: () {},
                  ),
                ],
              ),
            ),
            const WlmSectionLabel('Display'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: WlmTokens.spaceLg),
              child: Wrap(
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
                ],
              ),
            ),
            const WlmSectionLabel('Spec sheet'),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: WlmTokens.spaceLg),
              child: Column(
                children: [
                  WlmSpecRow(label: 'Sources', value: 'WALLHAVEN · REDDIT · NASA'),
                  WlmSpecRow(label: 'Tracking', value: 'NONE'),
                  WlmSpecRow(label: 'Storage', value: 'ON DEVICE'),
                ],
              ),
            ),
            const WlmSectionLabel('Card'),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: WlmTokens.spaceLg),
              child: WlmCard(
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
            ),
            const SizedBox(height: WlmTokens.spaceMd),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: WlmTokens.spaceLg),
              child: WlmSwitchTile(
                title: 'Daily wallpaper',
                subtitle: 'Rotate a new wallpaper each morning',
                value: _switch,
                onChanged: (v) => setState(() => _switch = v),
                trailingBadge: const WlmBadge(label: 'New'),
              ),
            ),
            const WlmSectionLabel('Feedback'),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: WlmTokens.spaceLg),
                child: Column(
                  children: [
                    const WlmLoader(label: 'Fetching wallpapers'),
                    const SizedBox(height: WlmTokens.spaceLg),
                    const WlmScanBar(),
                    const SizedBox(height: WlmTokens.spaceLg),
                    Wrap(
                      spacing: WlmTokens.spaceMd,
                      runSpacing: WlmTokens.spaceSm,
                      alignment: WrapAlignment.center,
                      children: [
                        WlmPrimaryButton(
                          label: 'Snackbar',
                          onPressed: () => WlmSnack.show(
                            context,
                            'Saved to favourites',
                            actionLabel: 'Undo',
                          ),
                        ),
                        WlmSecondaryButton(
                          label: 'Dialog',
                          onPressed: () => WlmDialog.show(
                            context,
                            title: 'Delete favourite?',
                            body: 'This will remove the wallpaper from your '
                                'on-device favourites list.',
                            confirmLabel: 'Delete',
                            destructive: true,
                          ),
                        ),
                        WlmGhostButton(
                          label: 'Bottom sheet',
                          onPressed: () => showWlmBottomSheet<void>(
                            context: context,
                            builder: (ctx) => Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const WlmSectionLabel('Quick actions'),
                                WlmActionRow(
                                  icon: Icons.favorite_border,
                                  label: 'Add to favourites',
                                  onTap: () => Navigator.pop(ctx),
                                ),
                                WlmActionRow(
                                  icon: Icons.share_outlined,
                                  label: 'Share link',
                                  onTap: () => Navigator.pop(ctx),
                                ),
                                WlmActionRow(
                                  icon: Icons.delete_outline,
                                  label: 'Remove',
                                  destructive: true,
                                  onTap: () => Navigator.pop(ctx),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
      bottomNavigationBar: WlmBottomNav(
        currentIndex: _tab,
        onTap: (i) => setState(() => _tab = i),
        items: const [
          WlmNavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home,
            label: 'Home',
          ),
          WlmNavItem(icon: Icons.search_rounded, label: 'Search'),
          WlmNavItem(
            icon: Icons.bookmark_outline,
            activeIcon: Icons.bookmark,
            label: 'Saved',
          ),
          WlmNavItem(icon: Icons.settings_outlined, label: 'Settings'),
        ],
      ),
    );
  }
}
