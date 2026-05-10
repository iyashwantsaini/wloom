import 'package:flutter/material.dart';

import '../tokens/wlm_motion.dart';
import '../utils/wlm_a11y.dart';

/// On-brand page transitions.
///
/// wloom routes use short, quiet, mono-flavoured transitions that
/// honour `MediaQuery.disableAnimations` automatically.
///
/// Three flavours are provided as named constructors:
///
/// - [WlmPageRoute.fade] — the safe default; cross-fades content.
/// - [WlmPageRoute.sharedAxis] — slides + fades along an axis (great
///   for forward/back navigation in a flow).
/// - [WlmPageRoute.fadeThrough] — fades old content to surface, then
///   fades new content in (great for top-level tab switches).
///
/// ```dart
/// Navigator.of(context).push(
///   WlmPageRoute.sharedAxis(
///     builder: (_) => const DetailPage(),
///   ),
/// );
/// ```
///
/// Pair with `Hero(tag: ..., child: ...)` to lift specific elements
/// across the transition (e.g. an image tile expanding into a detail
/// view).
class WlmPageRoute<T> extends PageRouteBuilder<T> {
  WlmPageRoute._({
    required WidgetBuilder builder,
    required this.transitionType,
    this.axis = Axis.horizontal,
    Duration? duration,
    super.fullscreenDialog,
    super.maintainState,
    super.barrierColor,
    super.barrierDismissible,
    super.opaque = true,
    super.settings,
  })  : _duration = duration ?? WlmMotion.medium,
        super(
          pageBuilder: (ctx, a, b) => builder(ctx),
          transitionsBuilder: (ctx, a, b, child) =>
              _buildTransition(ctx, a, b, child, transitionType, axis),
          transitionDuration: duration ?? WlmMotion.medium,
          reverseTransitionDuration: duration ?? WlmMotion.medium,
        );

  /// Fade-only transition. Cheap, quiet, the safe default.
  factory WlmPageRoute.fade({
    required WidgetBuilder builder,
    Duration? duration,
    bool fullscreenDialog = false,
    RouteSettings? settings,
  }) =>
      WlmPageRoute._(
        builder: builder,
        transitionType: _WlmPageTransition.fade,
        duration: duration,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );

  /// Slides the new page in along [axis] while fading. Use for
  /// forward/back navigation within a single hierarchy (e.g. list →
  /// detail).
  factory WlmPageRoute.sharedAxis({
    required WidgetBuilder builder,
    Axis axis = Axis.horizontal,
    Duration? duration,
    bool fullscreenDialog = false,
    RouteSettings? settings,
  }) =>
      WlmPageRoute._(
        builder: builder,
        transitionType: _WlmPageTransition.sharedAxis,
        axis: axis,
        duration: duration,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );

  /// Fades old content out, then fades new content in. Use for
  /// switching between top-level destinations (tabs, drawer items).
  factory WlmPageRoute.fadeThrough({
    required WidgetBuilder builder,
    Duration? duration,
    bool fullscreenDialog = false,
    RouteSettings? settings,
  }) =>
      WlmPageRoute._(
        builder: builder,
        transitionType: _WlmPageTransition.fadeThrough,
        duration: duration,
        fullscreenDialog: fullscreenDialog,
        settings: settings,
      );

  final _WlmPageTransition transitionType;
  final Axis axis;
  final Duration _duration;

  @override
  Duration get transitionDuration => _duration;
}

enum _WlmPageTransition { fade, sharedAxis, fadeThrough }

Widget _buildTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondary,
  Widget child,
  _WlmPageTransition type,
  Axis axis,
) {
  if (WlmA11y.reducedMotion(context)) return child;

  final eased = CurvedAnimation(parent: animation, curve: WlmMotion.standard);
  final easedSecondary =
      CurvedAnimation(parent: secondary, curve: WlmMotion.standard);

  switch (type) {
    case _WlmPageTransition.fade:
      return FadeTransition(opacity: eased, child: child);

    case _WlmPageTransition.sharedAxis:
      final dir = axis == Axis.horizontal
          ? const Offset(0.04, 0)
          : const Offset(0, 0.04);
      return FadeTransition(
        opacity: eased,
        child: SlideTransition(
          position: Tween<Offset>(begin: dir, end: Offset.zero).animate(eased),
          child: SlideTransition(
            position: Tween<Offset>(begin: Offset.zero, end: -dir)
                .animate(easedSecondary),
            child: child,
          ),
        ),
      );

    case _WlmPageTransition.fadeThrough:
      return FadeTransition(
        opacity: eased,
        child: ScaleTransition(
          scale: Tween<double>(begin: 0.98, end: 1.0).animate(eased),
          child: child,
        ),
      );
  }
}
