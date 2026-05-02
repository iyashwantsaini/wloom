import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import 'wlm_network_image.dart';

/// Two-layer progressive image: a fast low-resolution [thumbUrl] is
/// shown immediately, then a higher-resolution [hiResUrl] fades in once
/// it has decoded. Mirrors wolwo's wallpaper-tile loading strategy.
class WlmProgressiveImage extends StatefulWidget {
  const WlmProgressiveImage({
    super.key,
    required this.thumbUrl,
    required this.hiResUrl,
    this.fit = BoxFit.cover,
    this.radius = WlmTokens.radLg,
    this.aspectRatio,
  });

  final String thumbUrl;
  final String? hiResUrl;
  final BoxFit fit;
  final double radius;
  final double? aspectRatio;

  @override
  State<WlmProgressiveImage> createState() => _WlmProgressiveImageState();
}

class _WlmProgressiveImageState extends State<WlmProgressiveImage> {
  bool _hiResReady = false;

  @override
  Widget build(BuildContext context) {
    final stack = Stack(
      fit: StackFit.expand,
      children: [
        WlmNetworkImage(
          url: widget.thumbUrl,
          fit: widget.fit,
          radius: widget.radius,
        ),
        if (widget.hiResUrl != null)
          AnimatedOpacity(
            duration: const Duration(milliseconds: 220),
            opacity: _hiResReady ? 1.0 : 0.0,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(widget.radius),
              child: CachedNetworkImage(
                imageUrl: widget.hiResUrl!,
                fit: widget.fit,
                fadeInDuration: Duration.zero,
                placeholder: (_, __) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    if (mounted && !_hiResReady) {
                      setState(() => _hiResReady = true);
                    }
                  });
                  return const SizedBox.shrink();
                },
                errorWidget: (_, __, ___) => const SizedBox.shrink(),
              ),
            ),
          ),
      ],
    );

    if (widget.aspectRatio == null) return stack;
    return AspectRatio(aspectRatio: widget.aspectRatio!, child: stack);
  }
}
