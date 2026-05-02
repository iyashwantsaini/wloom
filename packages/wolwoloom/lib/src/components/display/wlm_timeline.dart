import 'package:flutter/material.dart';

import '../../theme/wlm_theme_extension.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// A single event on a [WlmTimeline].
class WlmTimelineEvent {
  const WlmTimelineEvent({
    required this.title,
    this.time,
    this.body,
    this.icon,
    this.color,
  });

  final String title;
  final String? time;
  final String? body;
  final IconData? icon;

  /// Override the marker / connector color for this single event.
  final Color? color;
}

/// Vertical event list with a hairline connector. Mono labels by default.
///
/// Customize via [markerColor], [connectorColor], [markerSize], [gap] and
/// per-event [WlmTimelineEvent.color].
class WlmTimeline extends StatelessWidget {
  const WlmTimeline({
    super.key,
    required this.events,
    this.markerColor,
    this.connectorColor,
    this.markerSize = 10,
    this.gap = WlmTokens.spaceLg,
    this.dense = false,
  });

  final List<WlmTimelineEvent> events;
  final Color? markerColor;
  final Color? connectorColor;
  final double markerSize;
  final double gap;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final wlm = WlmThemeExtension.of(context);
    final defaultMarker = markerColor ?? scheme.primary;
    final defaultConnector = connectorColor ?? wlm.hairline;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < events.length; i++)
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: markerSize + 12,
                  child: Column(
                    children: [
                      const SizedBox(height: 4),
                      Container(
                        width: markerSize,
                        height: markerSize,
                        decoration: BoxDecoration(
                          color: events[i].color ?? defaultMarker,
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      if (i != events.length - 1)
                        Expanded(
                          child: Container(
                            width: WlmTokens.hairline,
                            margin: const EdgeInsets.symmetric(vertical: 4),
                            color: defaultConnector,
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: WlmTokens.spaceMd),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: i == events.length - 1 ? 0 : gap,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (events[i].icon != null) ...[
                              Icon(
                                events[i].icon,
                                size: 14,
                                color: scheme.onSurface,
                              ),
                              const SizedBox(width: WlmTokens.spaceSm),
                            ],
                            Expanded(
                              child: Text(
                                events[i].title,
                                style: WlmType.label(scheme.onSurface)
                                    .copyWith(letterSpacing: 0.4),
                              ),
                            ),
                            if (events[i].time != null)
                              Text(
                                events[i].time!,
                                style: WlmType.tiny(scheme.outline),
                              ),
                          ],
                        ),
                        if (events[i].body != null && !dense) ...[
                          const SizedBox(height: WlmTokens.spaceXs),
                          Text(
                            events[i].body!,
                            style: WlmType.body(scheme.onSurfaceVariant)
                                .copyWith(height: 1.5),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}
