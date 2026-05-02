import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';

/// Wolwoloom segment class.
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
  });

  final List<WlmSegment<T>> segments;
  final T value;
  final ValueChanged<T> onChanged;
  final bool expand;

  @override
  Widget build(BuildContext context) {
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
