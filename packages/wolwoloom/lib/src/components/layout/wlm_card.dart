import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';

/// Solid surface card with hairline border (NOT glassmorphism).
class WlmCard extends StatelessWidget {
  const WlmCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(WlmTokens.spaceLg),
    this.radius = WlmTokens.radLg,
    this.elevated = false,
    this.onTap,
  });

  /// When `true`, uses `surfaceContainerHighest` instead of `surface`
  /// (used for nested content cards).
  final bool elevated;
  final Widget child;
  final EdgeInsetsGeometry padding;
  final double radius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final decoration = BoxDecoration(
      color: elevated ? scheme.surfaceContainerHighest : scheme.surface,
      borderRadius: BorderRadius.circular(radius),
      border: WlmTokens.hairlineBorder(scheme, opacity: elevated ? 0.20 : 0.30),
    );

    final body = Container(
      padding: padding,
      decoration: decoration,
      child: child,
    );

    if (onTap == null) return body;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(radius),
      child: body,
    );
  }
}
