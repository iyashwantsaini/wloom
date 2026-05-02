import 'package:flutter/material.dart';
import 'package:wolwoloom/wolwoloom.dart';

/// Dashboard / analytics screen with KPI cards, sparkline trend, and
/// a recent-activity timeline.
class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const _spark1 = <double>[4, 5, 4, 6, 7, 6, 8, 9, 8, 11];
  static const _spark2 = <double>[12, 9, 11, 8, 7, 6, 5, 6, 4, 3];
  static const _spark3 = <double>[2, 3, 4, 4, 5, 6, 7, 8, 9, 10];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: scheme.surfaceContainerLowest,
      appBar: WlmAppBar(
        title: 'dashboard',
        actions: [
          WlmHeaderIconButton(
            icon: Icons.notifications_none_rounded,
            onPressed: () {},
          ),
          WlmHeaderIconButton(
            icon: Icons.tune_rounded,
            onPressed: () {},
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (ctx, c) {
          final wide = c.maxWidth >= 720;
          return ListView(
            padding: const EdgeInsets.all(WlmTokens.spaceLg),
            children: [
              Text(
                'OVERVIEW',
                style: WlmType.tiny(scheme.outline)
                    .copyWith(letterSpacing: 1.6),
              ),
              const SizedBox(height: WlmTokens.spaceXs),
              Text(
                'Good morning, weaver.',
                style: WlmType.h1(scheme.onSurface).copyWith(
                  fontSize: wide ? 32 : 26,
                  letterSpacing: -0.6,
                ),
              ),
              const SizedBox(height: WlmTokens.spaceLg),
              if (wide)
                Row(
                  children: [
                    Expanded(
                      child: WlmKpiCard(
                        label: 'Active sessions',
                        value: '2,431',
                        delta: '+12.4% vs last week',
                        deltaPositive: true,
                        icon: Icons.bolt_outlined,
                        sparkline: _spark1,
                      ),
                    ),
                    const SizedBox(width: WlmTokens.spaceMd),
                    Expanded(
                      child: WlmKpiCard(
                        label: 'Bounce rate',
                        value: '38.2%',
                        delta: '-3.1% vs last week',
                        deltaPositive: false,
                        icon: Icons.trending_down_rounded,
                        sparkline: _spark2,
                      ),
                    ),
                    const SizedBox(width: WlmTokens.spaceMd),
                    Expanded(
                      child: WlmKpiCard(
                        label: 'Conversion',
                        value: '6.8%',
                        delta: '+0.7%',
                        deltaPositive: true,
                        icon: Icons.show_chart_rounded,
                        sparkline: _spark3,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    WlmKpiCard(
                      label: 'Active sessions',
                      value: '2,431',
                      delta: '+12.4% vs last week',
                      icon: Icons.bolt_outlined,
                      sparkline: _spark1,
                    ),
                    const SizedBox(height: WlmTokens.spaceSm),
                    WlmKpiCard(
                      label: 'Bounce rate',
                      value: '38.2%',
                      delta: '-3.1%',
                      deltaPositive: false,
                      icon: Icons.trending_down_rounded,
                      sparkline: _spark2,
                    ),
                    const SizedBox(height: WlmTokens.spaceSm),
                    WlmKpiCard(
                      label: 'Conversion',
                      value: '6.8%',
                      delta: '+0.7%',
                      icon: Icons.show_chart_rounded,
                      sparkline: _spark3,
                    ),
                  ],
                ),
              const SizedBox(height: WlmTokens.spaceXl),
              WlmSectionLabel(
                'Top channels',
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: WlmTokens.spaceMd),
              WlmSurface(
                padding: const EdgeInsets.all(WlmTokens.spaceLg),
                child: Column(
                  children: [
                    _channelRow(context, 'Organic', 0.62, '12.4k'),
                    const SizedBox(height: WlmTokens.spaceMd),
                    _channelRow(context, 'Direct', 0.42, '8.2k'),
                    const SizedBox(height: WlmTokens.spaceMd),
                    _channelRow(context, 'Referral', 0.28, '5.1k'),
                    const SizedBox(height: WlmTokens.spaceMd),
                    _channelRow(context, 'Social', 0.17, '3.0k'),
                  ],
                ),
              ),
              const SizedBox(height: WlmTokens.spaceXl),
              WlmSectionLabel(
                'Recent activity',
                padding: EdgeInsets.zero,
              ),
              const SizedBox(height: WlmTokens.spaceMd),
              WlmSurface(
                padding: const EdgeInsets.all(WlmTokens.spaceLg),
                child: WlmTimeline(
                  events: const [
                    WlmTimelineEvent(
                      title: 'Deploy succeeded · v0.3.1',
                      time: '2m ago',
                      body: 'Pages workflow finished in 1m 42s.',
                      icon: Icons.rocket_launch_rounded,
                    ),
                    WlmTimelineEvent(
                      title: 'New PR · #42 from @miko',
                      time: '14m ago',
                      body: 'feat(timeline): add per-event color overrides',
                      icon: Icons.code_rounded,
                    ),
                    WlmTimelineEvent(
                      title: 'CI passed on main',
                      time: '32m ago',
                      icon: Icons.check_circle_outline_rounded,
                    ),
                    WlmTimelineEvent(
                      title: 'Issue triaged · #38',
                      time: '1h ago',
                      icon: Icons.bug_report_outlined,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _channelRow(
      BuildContext context, String label, double pct, String count) {
    final scheme = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: WlmType.label(scheme.onSurface)
                    .copyWith(letterSpacing: 0.4),
              ),
            ),
            Text(count, style: WlmType.meta(scheme.outline)),
          ],
        ),
        const SizedBox(height: WlmTokens.spaceSm),
        WlmProgressBar(value: pct),
      ],
    );
  }
}
