import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../media/wlm_network_image.dart';

enum WlmAvatarShape { square, circle }

/// Square (default) or circular avatar with initials fallback.
class WlmAvatar extends StatelessWidget {
  const WlmAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 40,
    this.shape = WlmAvatarShape.square,
    this.background,
  });

  final String? imageUrl;
  final String? initials;
  final double size;
  final WlmAvatarShape shape;
  final Color? background;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final radius = shape == WlmAvatarShape.circle ? size / 2 : WlmTokens.radSm;
    final bg = background ?? scheme.surfaceContainerHighest;

    final inner = imageUrl != null
        ? WlmNetworkImage(
            url: imageUrl!,
            width: size,
            height: size,
            radius: radius,
            placeholderColor: bg,
          )
        : Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: bg,
              borderRadius: BorderRadius.circular(radius),
              border: WlmTokens.hairlineBorder(scheme),
            ),
            alignment: Alignment.center,
            child: Text(
              (initials ?? '').toUpperCase(),
              style: WlmType.label(scheme.onSurface).copyWith(
                fontSize: size * 0.32,
                letterSpacing: 1.0,
              ),
            ),
          );

    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: inner,
    );
  }
}
