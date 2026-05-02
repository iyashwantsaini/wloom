import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

import '../catalog_scaffold.dart';

class ButtonsPage extends StatelessWidget {
  const ButtonsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CatalogScaffold(
      title: 'Buttons',
      intro:
          'Six button variants — all use mono ALL-CAPS labels and the same '
          'tap-target footprint so they line up cleanly in any row.',
      sections: [
        Section(
          label: 'Primary',
          children: [
            Wrap(
              spacing: WlmTokens.spaceSm,
              runSpacing: WlmTokens.spaceSm,
              children: [
                WlmPrimaryButton(label: 'Continue', onPressed: () {}),
                WlmPrimaryButton(
                  label: 'Save',
                  icon: Icons.check_rounded,
                  onPressed: () {},
                ),
                const WlmPrimaryButton(label: 'Disabled', onPressed: null),
              ],
            ),
            WlmPrimaryButton(label: 'Expanded', expand: true, onPressed: () {}),
          ],
        ),
        Section(
          label: 'Secondary',
          children: [
            Wrap(
              spacing: WlmTokens.spaceSm,
              runSpacing: WlmTokens.spaceSm,
              children: [
                WlmSecondaryButton(label: 'Skip', onPressed: () {}),
                WlmSecondaryButton(
                  label: 'Try again',
                  icon: Icons.refresh_rounded,
                  onPressed: () {},
                ),
                const WlmSecondaryButton(label: 'Disabled', onPressed: null),
              ],
            ),
          ],
        ),
        Section(
          label: 'Ghost',
          children: [
            Wrap(
              spacing: WlmTokens.spaceSm,
              runSpacing: WlmTokens.spaceSm,
              children: [
                WlmGhostButton(label: 'Back', onPressed: () {}),
                WlmGhostButton(
                  label: 'See all',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        Section(
          label: 'Icon',
          children: [
            Wrap(
              spacing: WlmTokens.spaceMd,
              runSpacing: WlmTokens.spaceMd,
              children: [
                WlmIconButton(icon: Icons.favorite_border, onPressed: () {}),
                WlmIconButton(
                  icon: Icons.favorite,
                  outlined: true,
                  onPressed: () {},
                ),
                WlmHeaderIconButton(
                  icon: Icons.tune_rounded,
                  tooltip: 'Filters',
                  onPressed: () {},
                ),
                WlmHeaderIconButton(
                  icon: Icons.notifications_outlined,
                  badge: true,
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
        Section(
          label: 'Floating action',
          children: [
            Wrap(
              spacing: WlmTokens.spaceMd,
              runSpacing: WlmTokens.spaceMd,
              children: [
                WlmFab(icon: Icons.add_rounded, onPressed: () {}),
                WlmFab(
                  icon: Icons.edit_rounded,
                  label: 'Compose',
                  onPressed: () {},
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
