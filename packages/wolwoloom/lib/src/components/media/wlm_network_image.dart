import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../tokens/wlm_tokens.dart';

/// Cached network image with shimmer placeholder and graceful failure
/// state (renders an empty surface tinted by [placeholderColor]).
class WlmNetworkImage extends StatelessWidget {
  const WlmNetworkImage({
    super.key,
    required this.url,
    this.fit = BoxFit.cover,
    this.placeholderColor,
    this.radius = WlmTokens.radLg,
    this.fadeIn = const Duration(milliseconds: 220),
    this.width,
    this.height,
  });

  final String url;
  final BoxFit fit;
  final Color? placeholderColor;
  final double radius;
  final Duration fadeIn;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final placeholder = placeholderColor ?? scheme.surfaceContainerHighest;
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: fit,
        width: width,
        height: height,
        fadeInDuration: fadeIn,
        placeholder: (_, __) => Shimmer.fromColors(
          baseColor: placeholder,
          highlightColor: placeholder.withValues(alpha: 0.6),
          child: Container(color: placeholder),
        ),
        errorWidget: (_, __, ___) => Container(color: placeholder),
      ),
    );
  }
}
