import 'package:flutter/material.dart';

import '../../tokens/wlm_motion.dart';
import '../../tokens/wlm_size.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../../utils/wlm_a11y.dart';

/// Visual variant of [WlmButton]. Maps to the previous standalone
/// `WlmPrimaryButton`, `WlmSecondaryButton`, `WlmGhostButton`.
enum WlmButtonVariant {
  /// Filled ink button — the page's call-to-action.
  primary,

  /// Hairline-bordered button — the secondary action.
  secondary,

  /// Borderless mono label — the tertiary action.
  ghost,

  /// Filled red button — destructive call-to-action.
  destructive,
}

/// Single unified button with [variant], [size], [loading] and
/// [destructive] knobs. The standalone aliases (`WlmPrimaryButton`,
/// `WlmSecondaryButton`, `WlmGhostButton`) wrap this for backwards
/// compatibility.
class WlmButton extends StatefulWidget {
  const WlmButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = WlmButtonVariant.primary,
    this.size = WlmSize.md,
    this.icon,
    this.trailingIcon,
    this.loading = false,
    this.expand = false,
    this.uppercase = true,
    this.tooltip,
    this.focusNode,
    this.autofocus = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final WlmButtonVariant variant;
  final WlmSize size;
  final IconData? icon;
  final IconData? trailingIcon;
  final bool loading;
  final bool expand;
  final bool uppercase;
  final String? tooltip;
  final FocusNode? focusNode;
  final bool autofocus;

  @override
  State<WlmButton> createState() => _WlmButtonState();
}

class _WlmButtonState extends State<WlmButton> {
  bool _hovering = false;
  bool _focused = false;
  bool _pressed = false;

  bool get _disabled => widget.onPressed == null || widget.loading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final h = wlmBySize(widget.size, sm: 32.0, md: 40.0, lg: 48.0);
    final padH = wlmBySize(widget.size,
        sm: WlmTokens.spaceMd, md: WlmTokens.spaceLg, lg: WlmTokens.spaceXl,);
    final iconSize = wlmBySize(widget.size, sm: 12.0, md: 14.0, lg: 16.0);
    final fontSize = wlmBySize(widget.size, sm: 9.0, md: 10.0, lg: 12.0);

    final colors = _resolveColors(scheme);
    final radius = BorderRadius.circular(WlmTokens.radMd);

    final content = AnimatedSwitcher(
      duration: WlmA11y.motion(context, WlmMotion.fast),
      transitionBuilder: (c, a) =>
          FadeTransition(opacity: a, child: ScaleTransition(scale: a, child: c)),
      child: widget.loading
          ? SizedBox(
              key: const ValueKey('loading'),
              width: iconSize + 2,
              height: iconSize + 2,
              child: CircularProgressIndicator(
                strokeWidth: 1.5,
                color: colors.fg,
              ),
            )
          : Row(
              key: const ValueKey('idle'),
              mainAxisSize: widget.expand ? MainAxisSize.max : MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.icon != null) ...[
                  Icon(widget.icon, size: iconSize, color: colors.fg),
                  SizedBox(width: WlmTokens.spaceSm),
                ],
                Flexible(
                  child: Text(
                    widget.uppercase ? widget.label.toUpperCase() : widget.label,
                    overflow: TextOverflow.ellipsis,
                    style: WlmType.label(colors.fg).copyWith(
                      fontSize: fontSize,
                      letterSpacing: 1.4,
                    ),
                  ),
                ),
                if (widget.trailingIcon != null) ...[
                  SizedBox(width: WlmTokens.spaceSm),
                  Icon(widget.trailingIcon, size: iconSize, color: colors.fg),
                ],
              ],
            ),
    );

    final btn = Semantics(
      button: true,
      enabled: !_disabled,
      label: widget.tooltip ?? widget.label,
      child: AnimatedContainer(
        duration: WlmA11y.motion(context, WlmMotion.fast),
        curve: WlmMotion.standard,
        height: h,
        constraints: BoxConstraints(minWidth: h),
        padding: EdgeInsets.symmetric(horizontal: padH),
        decoration: BoxDecoration(
          color: colors.bg,
          borderRadius: radius,
          border: colors.border,
          boxShadow: _focused && !_disabled
              ? [
                  BoxShadow(
                    color: scheme.secondary.withValues(alpha: 0.35),
                    blurRadius: 0,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Center(child: content),
      ),
    );

    Widget core = FocusableActionDetector(
      focusNode: widget.focusNode,
      autofocus: widget.autofocus,
      enabled: !_disabled,
      mouseCursor:
          _disabled ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onShowFocusHighlight: (v) => setState(() => _focused = v),
      onShowHoverHighlight: (v) => setState(() => _hovering = v),
      actions: <Type, Action<Intent>>{
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            widget.onPressed?.call();
            return null;
          },
        ),
      },
      child: GestureDetector(
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) => setState(() => _pressed = false),
        onTap: _disabled ? null : widget.onPressed,
        child: btn,
      ),
    );

    if (widget.tooltip != null) {
      core = Tooltip(message: widget.tooltip!, child: core);
    }
    return widget.expand ? SizedBox(width: double.infinity, child: core) : core;
  }

  _ButtonColors _resolveColors(ColorScheme scheme) {
    final variant = widget.variant;
    Color bg, fg;
    BoxBorder? border;

    switch (variant) {
      case WlmButtonVariant.primary:
        bg = scheme.onSurface;
        fg = scheme.surface;
        if (_hovering) bg = bg.withValues(alpha: 0.86);
        if (_pressed) bg = bg.withValues(alpha: 0.78);
        border = null;
      case WlmButtonVariant.secondary:
        bg = _hovering
            ? scheme.surfaceContainerHighest.withValues(alpha: 0.6)
            : Colors.transparent;
        fg = scheme.onSurface;
        border = WlmTokens.hairlineBorder(scheme, opacity: 0.6);
      case WlmButtonVariant.ghost:
        bg = _hovering
            ? scheme.onSurface.withValues(alpha: 0.06)
            : Colors.transparent;
        fg = scheme.onSurface;
        border = null;
      case WlmButtonVariant.destructive:
        bg = scheme.error;
        fg = scheme.onError;
        if (_hovering) bg = bg.withValues(alpha: 0.86);
        if (_pressed) bg = bg.withValues(alpha: 0.78);
        border = null;
    }

    if (_disabled) {
      bg = (variant == WlmButtonVariant.secondary ||
              variant == WlmButtonVariant.ghost)
          ? Colors.transparent
          : bg.withValues(alpha: 0.35);
      fg = fg.withValues(alpha: 0.45);
      if (border != null) {
        border = WlmTokens.hairlineBorder(scheme, opacity: 0.2);
      }
    }
    return _ButtonColors(bg: bg, fg: fg, border: border);
  }
}

class _ButtonColors {
  const _ButtonColors({required this.bg, required this.fg, this.border});
  final Color bg;
  final Color fg;
  final BoxBorder? border;
}
