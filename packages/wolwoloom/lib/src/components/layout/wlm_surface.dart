import 'package:flutter/material.dart';

import '../../theme/wlm_theme_extension.dart';
import '../../tokens/wlm_tokens.dart';

/// Generic styled container that exposes the full Wolwoloom modifier API.
///
/// Use this when you need to wrap arbitrary content with a consistent
/// background / border / radius / padding — without writing a one-off
/// `Container` + `BoxDecoration`. Every visual prop is overridable.
///
/// ```dart
/// WlmSurface(
///   color: scheme.surfaceContainerHighest,
///   radius: WlmTokens.radMd,
///   padding: const EdgeInsets.all(WlmTokens.spaceLg),
///   border: WlmSurfaceBorder.hairline,
///   child: ...,
/// );
/// ```
class WlmSurface extends StatelessWidget {
  const WlmSurface({
    super.key,
    required this.child,
    this.color,
    this.borderColor,
    this.border = WlmSurfaceBorder.hairline,
    this.borderWidth = WlmTokens.hairline,
    this.radius = WlmTokens.radMd,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.alignment,
    this.gradient,
    this.shadow = WlmSurfaceShadow.none,
    this.onTap,
  });

  final Widget child;
  final Color? color;
  final Color? borderColor;
  final WlmSurfaceBorder border;
  final double borderWidth;
  final double radius;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final AlignmentGeometry? alignment;
  final Gradient? gradient;
  final WlmSurfaceShadow shadow;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final wlm = WlmThemeExtension.of(context);

    Border? resolvedBorder;
    switch (border) {
      case WlmSurfaceBorder.none:
        resolvedBorder = null;
        break;
      case WlmSurfaceBorder.hairline:
        resolvedBorder = Border.all(
          color: borderColor ?? wlm.hairline,
          width: borderWidth,
        );
        break;
      case WlmSurfaceBorder.bold:
        resolvedBorder = Border.all(
          color: borderColor ?? scheme.onSurface,
          width: WlmTokens.border,
        );
        break;
    }

    final List<BoxShadow>? shadows = switch (shadow) {
      WlmSurfaceShadow.none => null,
      WlmSurfaceShadow.soft => [
          BoxShadow(
            color:
                Colors.black.withValues(alpha: WlmTokens.elevationOpacityLow),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      WlmSurfaceShadow.medium => [
          BoxShadow(
            color:
                Colors.black.withValues(alpha: WlmTokens.elevationOpacityMid),
            blurRadius: 24,
            offset: const Offset(0, 6),
          ),
        ],
    };

    final body = Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      alignment: alignment,
      decoration: BoxDecoration(
        color: gradient == null ? (color ?? scheme.surface) : null,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
        border: resolvedBorder,
        boxShadow: shadows,
      ),
      child: child,
    );

    if (onTap == null) return body;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(radius),
        child: body,
      ),
    );
  }
}

/// Wolwoloom surface border enum.
enum WlmSurfaceBorder { none, hairline, bold }

/// Wolwoloom surface shadow enum.
enum WlmSurfaceShadow { none, soft, medium }
