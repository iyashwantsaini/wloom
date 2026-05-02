import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../tokens/wlm_tokens.dart';

/// Generic shimmering placeholder block. Match the shape of the
/// component you're loading (height/width/radius) and Wolwoloom will
/// shimmer it in surface tones.
class WlmSkeleton extends StatelessWidget {
  const WlmSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.radius = WlmTokens.radSm,
  });

  final double? width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final base = scheme.surfaceContainerHighest;
    final highlight = Color.alphaBlend(
      scheme.onSurface.withValues(alpha: 0.04),
      base,
    );
    return Shimmer.fromColors(
      baseColor: base,
      highlightColor: highlight,
      period: const Duration(milliseconds: 1500),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(radius),
        ),
      ),
    );
  }
}
