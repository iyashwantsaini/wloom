import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import '../catalog_scaffold.dart';

class OverlaysPage extends StatelessWidget {
  const OverlaysPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CatalogScaffold(
      title: 'Overlays',
      sections: [
        Section(
          label: 'Bottom sheet',
          children: [
            Builder(
              builder: (ctx) => WlmPrimaryButton(
                label: 'Open sheet',
                onPressed: () => showWlmBottomSheet<void>(
                  context: ctx,
                  builder: (sheetCtx) => Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: WlmTokens.spaceLg,
                        ),
                        child: WlmSectionLabel('Quick actions'),
                      ),
                      WlmActionRow(
                        icon: Icons.favorite_border,
                        label: 'Add to favourites',
                        onTap: () => Navigator.pop(sheetCtx),
                      ),
                      WlmActionRow(
                        icon: Icons.share_outlined,
                        label: 'Share link',
                        onTap: () => Navigator.pop(sheetCtx),
                      ),
                      WlmActionRow(
                        icon: Icons.delete_outline,
                        label: 'Remove',
                        destructive: true,
                        onTap: () => Navigator.pop(sheetCtx),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        Section(
          label: 'Dialog',
          children: [
            Wrap(
              spacing: WlmTokens.spaceSm,
              runSpacing: WlmTokens.spaceSm,
              children: [
                Builder(
                  builder: (ctx) => WlmSecondaryButton(
                    label: 'Confirm',
                    onPressed: () => WlmDialog.show(
                      ctx,
                      title: 'Delete favourite?',
                      body: 'This will remove the wallpaper from your '
                          'on-device favourites list.',
                      confirmLabel: 'Delete',
                      destructive: true,
                    ),
                  ),
                ),
                Builder(
                  builder: (ctx) => WlmGhostButton(
                    label: 'Info',
                    onPressed: () => WlmDialog.show(
                      ctx,
                      title: 'About Wolwoloom',
                      body: 'Editorial / typewriter Flutter design system. '
                          'MIT licensed.',
                      confirmLabel: 'OK',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
        Section(
          label: 'Popover & menu',
          caption: 'Anchor a sheet of options to any widget.',
          children: [
            Wrap(
              spacing: WlmTokens.spaceSm,
              runSpacing: WlmTokens.spaceSm,
              children: [
                WlmMenuButton(
                  title: 'Sort by',
                  items: const [
                    WlmMenuItem(label: 'Newest', icon: Icons.schedule_rounded),
                    WlmMenuItem(label: 'Top rated', icon: Icons.star_outline_rounded),
                    WlmMenuItem(label: 'Trending', icon: Icons.trending_up_rounded),
                    WlmMenuItem(label: 'Delete', icon: Icons.delete_outline, destructive: true),
                  ],
                  child: WlmGhostButton(label: 'Sort', icon: Icons.sort_rounded, onPressed: () {}),
                ),
              ],
            ),
          ],
        ),
        Section(
          label: 'Command palette',
          caption: 'Cmd-K style global launcher with keyboard nav.',
          children: [
            Builder(
              builder: (ctx) => WlmSecondaryButton(
                label: 'Open palette',
                icon: Icons.bolt_rounded,
                onPressed: () => WlmCommandPalette.show(
                  ctx,
                  commands: [
                    WlmCommand(
                      id: 'new',
                      label: 'New wallpaper',
                      group: 'Create',
                      icon: Icons.add_photo_alternate_outlined,
                      onRun: () {},
                    ),
                    WlmCommand(
                      id: 'fav',
                      label: 'Open favourites',
                      group: 'Navigate',
                      icon: Icons.favorite_border,
                      onRun: () {},
                    ),
                    WlmCommand(
                      id: 'theme',
                      label: 'Toggle theme',
                      group: 'Settings',
                      icon: Icons.contrast_rounded,
                      onRun: () {},
                    ),
                    WlmCommand(
                      id: 'logout',
                      label: 'Sign out',
                      group: 'Account',
                      icon: Icons.logout_rounded,
                      onRun: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
