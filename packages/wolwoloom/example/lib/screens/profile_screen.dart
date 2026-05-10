import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

/// Profile / account screen showing avatar header, KPI strip, and
/// segmented tabs over recent activity.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: WlmAppBar(
        title: 'profile',
        actions: [
          WlmHeaderIconButton(
            icon: Icons.share_outlined,
            onPressed: () {},
          ),
          WlmHeaderIconButton(
            icon: Icons.more_horiz_rounded,
            onPressed: () {},
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(WlmTokens.spaceLg),
        children: [
          // Header
          WlmSurface(
            padding: const EdgeInsets.all(WlmTokens.spaceXl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    WlmAvatar(initials: 'MK', size: 64),
                    const SizedBox(width: WlmTokens.spaceLg),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Miko Kurosawa',
                            style: WlmType.h2(scheme.onSurface)
                                .copyWith(letterSpacing: -0.4),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '@miko · Tokyo, JP',
                            style: WlmType.meta(scheme.outline),
                          ),
                          const SizedBox(height: WlmTokens.spaceSm),
                          Row(
                            children: [
                              WlmBadge(label: 'PRO'),
                              const SizedBox(width: WlmTokens.spaceSm),
                              WlmTag(label: 'verified'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: WlmTokens.spaceLg),
                Text(
                  'Designer · loves monospaced UI, mechanical keyboards, '
                  'and editorial typography. Building wloom with too '
                  'much coffee.',
                  style: WlmType.body(scheme.onSurfaceVariant)
                      .copyWith(height: 1.5),
                ),
                const SizedBox(height: WlmTokens.spaceLg),
                Row(
                  children: [
                    Expanded(
                      child: WlmPrimaryButton(
                        label: 'FOLLOW',
                        onPressed: () {},
                        icon: Icons.add_rounded,
                        expand: true,
                      ),
                    ),
                    const SizedBox(width: WlmTokens.spaceSm),
                    Expanded(
                      child: WlmGhostButton(
                        label: 'MESSAGE',
                        onPressed: () {},
                        icon: Icons.mail_outline_rounded,
                        expand: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: WlmTokens.spaceLg),
          // Stats strip
          WlmSurface(
            padding: const EdgeInsets.symmetric(
              horizontal: WlmTokens.spaceMd,
              vertical: WlmTokens.spaceLg,
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: WlmTokens.spaceMd),
                      child: WlmStat(label: 'Followers', value: '12.4k'),
                    ),
                  ),
                  Container(
                    width: WlmTokens.hairline,
                    color: WlmThemeExtension.of(context).hairline,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: WlmTokens.spaceMd),
                      child: WlmStat(label: 'Following', value: '284'),
                    ),
                  ),
                  Container(
                    width: WlmTokens.hairline,
                    color: WlmThemeExtension.of(context).hairline,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: WlmTokens.spaceMd),
                      child: WlmStat(label: 'Repos', value: '47'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: WlmTokens.spaceLg),
          WlmSegmentedControl<int>(
            value: _tab,
            segments: const [
              WlmSegment(value: 0, label: 'POSTS'),
              WlmSegment(value: 1, label: 'PROJECTS'),
              WlmSegment(value: 2, label: 'STARS'),
            ],
            onChanged: (v) => setState(() => _tab = v),
          ),
          const SizedBox(height: WlmTokens.spaceLg),
          if (_tab == 0) ..._posts(context),
          if (_tab == 1) ..._projects(context),
          if (_tab == 2) ..._stars(context),
        ],
      ),
    );
  }

  List<Widget> _posts(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return [
      for (final p in const [
        ['Shipping wloom 0.3', '2d', 'New components, new screens.'],
        ['Editorial UI is back', '5d', 'Hairline borders forever.'],
        ['On density tokens', '1w', 'Why one density never fits all.'],
      ])
        Padding(
          padding: const EdgeInsets.only(bottom: WlmTokens.spaceSm),
          child: WlmSurface(
            padding: const EdgeInsets.all(WlmTokens.spaceLg),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        p[0],
                        style: WlmType.h3(scheme.onSurface),
                      ),
                    ),
                    Text(p[1], style: WlmType.tiny(scheme.outline)),
                  ],
                ),
                const SizedBox(height: WlmTokens.spaceXs),
                Text(p[2], style: WlmType.body(scheme.onSurfaceVariant)),
              ],
            ),
          ),
        ),
    ];
  }

  List<Widget> _projects(BuildContext context) {
    return [
      for (final p in const [
        ['wloom', 'Editorial Flutter design system', '★ 1.2k'],
        ['ink-on-paper', 'Color tokens for monospace UIs', '★ 312'],
        ['mono-icons', 'Hairline icon set', '★ 98'],
      ])
        Padding(
          padding: const EdgeInsets.only(bottom: WlmTokens.spaceSm),
          child: WlmSurface(
            padding: EdgeInsets.zero,
            child: WlmListTile(
              leading: const Icon(Icons.folder_outlined, size: 18),
              title: p[0],
              subtitle: p[1],
              trailing: Text(
                p[2],
                style:
                    WlmType.tiny(Theme.of(context).colorScheme.outline),
              ),
              onTap: () {},
            ),
          ),
        ),
    ];
  }

  List<Widget> _stars(BuildContext context) {
    return [
      WlmEmptyState(
        title: 'No stars yet',
        body: 'Repos you star will show up here.',
        icon: Icons.star_outline_rounded,
      ),
    ];
  }
}
