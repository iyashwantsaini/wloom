import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import 'wlm_loader.dart';

/// Shimmering masonry skeleton that mirrors a staggered grid layout
/// while data is loading. Heights are deterministic so successive
/// rebuilds don't reflow.
class WlmGridSkeleton extends StatelessWidget {
  const WlmGridSkeleton({
    super.key,
    this.crossAxisCount = 2,
    this.itemCount = 8,
    this.label = 'LOADING',
  });

  final int crossAxisCount;
  final int itemCount;
  final String label;

  static const _heights = <double>[
    220, 280, 200, 320, 240, 300, 260, 220, 340, 200, 280, 240,
  ];

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = scheme.surfaceContainerHighest;
    final highlight = Color.alphaBlend(
      scheme.onSurface.withValues(alpha: 0.04),
      base,
    );

    return Padding(
      padding: const EdgeInsets.fromLTRB(
        WlmTokens.spaceMd,
        WlmTokens.spaceMd,
        WlmTokens.spaceMd,
        WlmTokens.spaceLg,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WlmLoader(label: label, compact: true, size: 18),
              const SizedBox(width: WlmTokens.spaceMd),
              Text(
                label.toUpperCase(),
                style: WlmType.label(scheme.outline)
                    .copyWith(letterSpacing: 1.4),
              ),
            ],
          ),
          const SizedBox(height: WlmTokens.spaceLg),
          Expanded(
            child: Shimmer.fromColors(
              baseColor: base,
              highlightColor: highlight,
              period: const Duration(milliseconds: 1500),
              child: _MasonrySkeleton(
                crossAxisCount: crossAxisCount,
                itemCount: itemCount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MasonrySkeleton extends StatelessWidget {
  const _MasonrySkeleton({
    required this.crossAxisCount,
    required this.itemCount,
  });
  final int crossAxisCount;
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    final colHeights = List<double>.filled(crossAxisCount, 0);
    final colChildren = List.generate(crossAxisCount, (_) => <Widget>[]);

    for (var i = 0; i < itemCount; i++) {
      var minIdx = 0;
      for (var c = 1; c < crossAxisCount; c++) {
        if (colHeights[c] < colHeights[minIdx]) minIdx = c;
      }
      final h = WlmGridSkeleton._heights[i % WlmGridSkeleton._heights.length];
      colChildren[minIdx].add(
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            height: h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(WlmTokens.radLg),
            ),
          ),
        ),
      );
      colHeights[minIdx] += h + 10;
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var c = 0; c < crossAxisCount; c++) ...[
          if (c > 0) const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: colChildren[c],
            ),
          ),
        ],
      ],
    );
  }
}
