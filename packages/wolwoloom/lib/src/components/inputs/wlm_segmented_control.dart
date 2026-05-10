import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Visual variant of [WlmSegmentedControl].
enum WlmSegmentedVariant {
  /// Hairline-bordered track with rounded selected pill (default).
  track,

  /// Borderless row of all-caps text segments separated by hairlines —
  /// ideal for "All / Photos / Videos" tab pickers.
  pill,
}

/// wloom segment class.
class WlmSegment<T> {
  const WlmSegment({required this.value, required this.label, this.icon});
  final T value;
  final String label;
  final IconData? icon;
}

/// Hairline-bordered segmented control. The selected pill animates
/// across the track with a 220ms ease.
class WlmSegmentedControl<T> extends StatelessWidget {
  const WlmSegmentedControl({
    super.key,
    required this.segments,
    required this.value,
    required this.onChanged,
    this.expand = false,
    this.variant = WlmSegmentedVariant.track,
  });

  /// Convenience for text-only pill segments.
  ///
  /// ```dart
  /// WlmSegmentedControl.text(
  ///   segments: const ['ALL', 'PHOTOS', 'VIDEOS'],
  ///   value: tab,
  ///   onChanged: (v) => setState(() => tab = v),
  /// );
  /// ```
  static WlmSegmentedControl<String> text({
    Key? key,
    required List<String> segments,
    required String value,
    required ValueChanged<String> onChanged,
    bool expand = true,
    WlmSegmentedVariant variant = WlmSegmentedVariant.pill,
  }) {
    return WlmSegmentedControl<String>(
      key: key,
      segments: [
        for (final s in segments) WlmSegment(value: s, label: s),
      ],
      value: value,
      onChanged: onChanged,
      expand: expand,
      variant: variant,
    );
  }

  final List<WlmSegment<T>> segments;
  final T value;
  final ValueChanged<T> onChanged;
  final bool expand;
  final WlmSegmentedVariant variant;

  @override
  Widget build(BuildContext context) {
    return variant == WlmSegmentedVariant.pill
        ? _buildPill(context)
        : _buildTrack(context);
  }

  Widget _buildPill(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: scheme.outlineVariant.withValues(alpha: 0.30),
            width: WlmTokens.hairline,
          ),
        ),
      ),
      child: Row(
        mainAxisSize: expand ? MainAxisSize.max : MainAxisSize.min,
        children: [
          for (final s in segments)
            Expanded(
              flex: expand ? 1 : 0,
              child: InkWell(
                onTap: () => onChanged(s.value),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: WlmTokens.spaceLg,
                    vertical: WlmTokens.spaceMd,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: s.value == value
                            ? scheme.onSurface
                            : Colors.transparent,
                        width: 1.5,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      s.label.toUpperCase(),
                      style: WlmType.label(
                        s.value == value
                            ? scheme.onSurface
                            : scheme.onSurfaceVariant,
                      ).copyWith(letterSpacing: 1.4),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTrack(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final activeIndex = segments.indexWhere((s) => s.value == value);

    return LayoutBuilder(
      builder: (ctx, c) {
        final width = expand && c.hasBoundedWidth ? c.maxWidth : null;
        return Container(
          width: width,
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: scheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(WlmTokens.radMd),
            border: WlmTokens.hairlineBorder(scheme),
          ),
          child: LayoutBuilder(
            builder: (ctx, inner) {
              final segWidth = inner.hasBoundedWidth
                  ? inner.maxWidth / segments.length
                  : 96.0;
              return SizedBox(
                height: 32,
                child: Stack(
                  children: [
                    if (activeIndex >= 0)
                      AnimatedPositioned(
                        duration: const Duration(milliseconds: 220),
                        curve: Curves.easeOutCubic,
                        left: activeIndex * segWidth,
                        top: 0,
                        bottom: 0,
                        width: segWidth,
                        child: Container(
                          decoration: BoxDecoration(
                            color: scheme.onSurface,
                            borderRadius: BorderRadius.circular(WlmTokens.radSm),
                          ),
                        ),
                      ),
                    Row(
                      children: [
                        for (final s in segments)
                          SizedBox(
                            width: segWidth,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(WlmTokens.radSm),
                              onTap: () => onChanged(s.value),
                              child: Center(
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    if (s.icon != null) ...[
                                      Icon(
                                        s.icon,
                                        size: 12,
                                        color: s.value == value
                                            ? scheme.surface
                                            : scheme.onSurfaceVariant,
                                      ),
                                      const SizedBox(width: 6),
                                    ],
                                    Text(
                                      s.label.toUpperCase(),
                                      style: WlmType.tiny(
                                        s.value == value
                                            ? scheme.surface
                                            : scheme.onSurfaceVariant,
                                      ).copyWith(fontSize: 11, letterSpacing: 1.0),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
