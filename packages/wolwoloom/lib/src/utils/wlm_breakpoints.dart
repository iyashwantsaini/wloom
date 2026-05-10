import 'package:flutter/widgets.dart';

import '../tokens/wlm_tokens.dart';

/// Responsive breakpoint helper.
///
/// wloom is designed for **mobile, tablet, and web** out of the box.
/// Use this enum (and the [WlmResponsive] / [WlmResponsiveValue] helpers)
/// instead of raw `MediaQuery` checks so behaviour stays consistent
/// across components.
///
/// ```dart
/// final bp = WlmBreakpoint.of(context);
/// if (bp.isHandheld) {
///   return _MobileLayout();
/// }
/// return _TabletLayout();
/// ```
///
/// Width thresholds follow the
/// [Material 3 window-size classes](https://m3.material.io/foundations/layout/applying-layout/window-size-classes)
/// so wloom behaves predictably alongside other Material apps.
enum WlmBreakpoint {
  /// `<600` — phones in portrait.
  compact,

  /// `600–840` — phones in landscape, small tablets.
  medium,

  /// `840–1200` — tablets, small laptops.
  expanded,

  /// `1200–1600` — desktops.
  large,

  /// `≥1600` — wide desktops.
  extraLarge;

  /// Resolve the active breakpoint from [context].
  static WlmBreakpoint of(BuildContext context) =>
      fromWidth(MediaQuery.sizeOf(context).width);

  /// Pure helper — resolve a breakpoint from a raw pixel [width].
  static WlmBreakpoint fromWidth(double width) {
    if (width < 600) return WlmBreakpoint.compact;
    if (width < 840) return WlmBreakpoint.medium;
    if (width < 1200) return WlmBreakpoint.expanded;
    if (width < 1600) return WlmBreakpoint.large;
    return WlmBreakpoint.extraLarge;
  }

  bool get isCompact => this == WlmBreakpoint.compact;
  bool get isMedium => this == WlmBreakpoint.medium;
  bool get isExpanded => index >= WlmBreakpoint.expanded.index;
  bool get isLarge => index >= WlmBreakpoint.large.index;
  bool get isHandheld => index <= WlmBreakpoint.medium.index;
  bool get isDesktop => index >= WlmBreakpoint.expanded.index;
}

/// Resolves a value per-breakpoint without rebuilding a widget tree.
///
/// Useful for spacing, font-sizes, or grid column counts:
///
/// ```dart
/// final cols = const WlmResponsiveValue<int>(
///   compact: 2,
///   medium: 3,
///   expanded: 4,
///   large: 5,
/// ).resolve(context);
/// ```
class WlmResponsiveValue<T> {
  const WlmResponsiveValue({
    required this.compact,
    this.medium,
    this.expanded,
    this.large,
    this.extraLarge,
  });

  final T compact;
  final T? medium;
  final T? expanded;
  final T? large;
  final T? extraLarge;

  T resolve(BuildContext context) => resolveFor(WlmBreakpoint.of(context));

  T resolveFor(WlmBreakpoint bp) => switch (bp) {
        WlmBreakpoint.extraLarge =>
          extraLarge ?? large ?? expanded ?? medium ?? compact,
        WlmBreakpoint.large => large ?? expanded ?? medium ?? compact,
        WlmBreakpoint.expanded => expanded ?? medium ?? compact,
        WlmBreakpoint.medium => medium ?? compact,
        WlmBreakpoint.compact => compact,
      };
}

/// Renders the first builder whose breakpoint matches the current width.
/// Falls back to [compact] if no other builder is supplied.
///
/// ```dart
/// WlmResponsive(
///   compact: (_) => const _MobileShell(),
///   expanded: (_) => const _TabletShell(),
///   large: (_) => const _DesktopShell(),
/// );
/// ```
class WlmResponsive extends StatelessWidget {
  const WlmResponsive({
    super.key,
    required this.compact,
    this.medium,
    this.expanded,
    this.large,
    this.extraLarge,
  });

  final WidgetBuilder compact;
  final WidgetBuilder? medium;
  final WidgetBuilder? expanded;
  final WidgetBuilder? large;
  final WidgetBuilder? extraLarge;

  @override
  Widget build(BuildContext context) {
    final bp = WlmBreakpoint.of(context);
    return switch (bp) {
      WlmBreakpoint.extraLarge => (extraLarge ?? large ?? expanded ?? medium ?? compact)(context),
      WlmBreakpoint.large => (large ?? expanded ?? medium ?? compact)(context),
      WlmBreakpoint.expanded => (expanded ?? medium ?? compact)(context),
      WlmBreakpoint.medium => (medium ?? compact)(context),
      WlmBreakpoint.compact => compact(context),
    };
  }
}

/// Caps a child's width to a comfortable reading / form measure and
/// centers it horizontally — the canonical "page on a wide screen"
/// pattern.
///
/// ```dart
/// WlmCenteredColumn(
///   maxWidth: 720,
///   child: ListView(...),
/// );
/// ```
class WlmCenteredColumn extends StatelessWidget {
  const WlmCenteredColumn({
    super.key,
    required this.child,
    this.maxWidth = 720,
    this.padding,
  });

  final Widget child;
  final double maxWidth;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: padding ??
              const EdgeInsets.symmetric(horizontal: WlmTokens.gutter),
          child: child,
        ),
      ),
    );
  }
}

