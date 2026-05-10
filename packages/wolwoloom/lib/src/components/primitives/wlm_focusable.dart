import 'package:flutter/material.dart';

import '../../tokens/wlm_motion.dart';
import '../../tokens/wlm_tokens.dart';

/// On-brand keyboard focus indicator.
///
/// wloom's editorial / typewriter look conflicts with Material's
/// default blue focus halo. Wrap interactive widgets in [WlmFocusable]
/// (or use components that already do, like `WlmPrimaryButton`) to get
/// a hairline ink ring instead.
///
/// ```dart
/// WlmFocusable(
///   onTap: _open,
///   child: Padding(
///     padding: const EdgeInsets.all(WlmTokens.spaceMd),
///     child: Text('Custom tile'),
///   ),
/// );
/// ```
///
/// On web the ring appears whenever the user navigates with the
/// keyboard; on touch devices it stays hidden, matching platform
/// expectations.
class WlmFocusable extends StatefulWidget {
  const WlmFocusable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.focusNode,
    this.autofocus = false,
    this.borderRadius,
    this.padding = EdgeInsets.zero,
    this.ringColor,
    this.ringWidth = 1.5,
    this.ringInset = 2.0,
    this.enabled = true,
    this.semanticLabel,
  });

  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final FocusNode? focusNode;
  final bool autofocus;

  /// Defaults to [WlmTokens.radSm].
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry padding;

  /// Override the focus ring color (defaults to `colorScheme.onSurface`).
  final Color? ringColor;
  final double ringWidth;

  /// Distance the ring sits *outside* the child's bounds.
  final double ringInset;

  final bool enabled;
  final String? semanticLabel;

  @override
  State<WlmFocusable> createState() => _WlmFocusableState();
}

class _WlmFocusableState extends State<WlmFocusable> {
  bool _focused = false;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final ring = widget.ringColor ?? scheme.onSurface;
    final radius =
        widget.borderRadius ?? BorderRadius.circular(WlmTokens.radSm);

    return Semantics(
      button: widget.onTap != null,
      label: widget.semanticLabel,
      enabled: widget.enabled,
      child: Focus(
        focusNode: widget.focusNode,
        autofocus: widget.autofocus,
        canRequestFocus: widget.enabled,
        onFocusChange: (f) => setState(() => _focused = f),
        child: GestureDetector(
          onTap: widget.enabled ? widget.onTap : null,
          onLongPress: widget.enabled ? widget.onLongPress : null,
          behavior: HitTestBehavior.opaque,
          child: AnimatedContainer(
            duration: WlmMotion.fast,
            padding: widget.padding,
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(
                color: _focused ? ring : Colors.transparent,
                width: widget.ringWidth,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(widget.ringInset),
              child: widget.child,
            ),
          ),
        ),
      ),
    );
  }
}
