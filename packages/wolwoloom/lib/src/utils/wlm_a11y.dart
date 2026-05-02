import 'package:flutter/scheduler.dart';
import 'package:flutter/widgets.dart';

/// Accessibility helpers — read once per build instead of sprinkling
/// `MediaQuery.of(context).disableAnimations` everywhere.
class WlmA11y {
  WlmA11y._();

  /// `true` when the user has asked the OS to reduce motion. Honour by
  /// shortening or skipping animations.
  static bool reducedMotion(BuildContext context) =>
      MediaQuery.of(context).disableAnimations;

  /// Resolve an animation [duration] respecting reduced-motion.
  static Duration motion(BuildContext context, Duration duration) =>
      reducedMotion(context) ? Duration.zero : duration;

  /// `true` when high contrast is requested by the platform.
  static bool highContrast(BuildContext context) =>
      MediaQuery.of(context).highContrast;

  /// Whether keyboard focus highlighting should be visually rendered.
  static bool focusVisible(BuildContext context) =>
      FocusManager.instance.highlightMode == FocusHighlightMode.traditional;

  /// Convenience: schedules [callback] after the next frame.
  static void afterFrame(VoidCallback callback) =>
      SchedulerBinding.instance.addPostFrameCallback((_) => callback());
}
