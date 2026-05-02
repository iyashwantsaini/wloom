import 'package:flutter/widgets.dart';

/// Responsive breakpoint helper.
///
/// ```dart
/// final bp = WlmBreakpoint.of(context);
/// if (bp.isCompact) ... else ...
/// ```
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

  static WlmBreakpoint of(BuildContext context) {
    final w = MediaQuery.sizeOf(context).width;
    if (w < 600) return WlmBreakpoint.compact;
    if (w < 840) return WlmBreakpoint.medium;
    if (w < 1200) return WlmBreakpoint.expanded;
    if (w < 1600) return WlmBreakpoint.large;
    return WlmBreakpoint.extraLarge;
  }

  bool get isCompact => this == WlmBreakpoint.compact;
  bool get isMedium => this == WlmBreakpoint.medium;
  bool get isExpanded => index >= WlmBreakpoint.expanded.index;
  bool get isLarge => index >= WlmBreakpoint.large.index;
  bool get isHandheld => index <= WlmBreakpoint.medium.index;
  bool get isDesktop => index >= WlmBreakpoint.expanded.index;
}

/// Renders the first builder whose breakpoint matches the current width.
/// Falls back to [compact] if no other builder is supplied.
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
