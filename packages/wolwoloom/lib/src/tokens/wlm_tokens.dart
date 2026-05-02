import 'package:flutter/material.dart';

/// Spacing, radii, border and tap-target tokens used by every Wolwoloom
/// component. Numeric values are duplicated from the wolwo source app
/// so designs stay pixel-identical between the two.
class WlmTokens {
  WlmTokens._();

  // ── Spacing scale ─────────────────────────────────────────────────
  static const double spaceXs = 4.0;
  static const double spaceSm = 8.0;
  static const double spaceMd = 12.0;
  static const double spaceLg = 16.0;
  static const double spaceXl = 24.0;
  static const double spaceXxl = 32.0;

  // ── Radii ─────────────────────────────────────────────────────────
  static const double radSm = 6.0;
  static const double radMd = 12.0;
  static const double radLg = 16.0;
  static const double radXl = 20.0;
  static const double radPill = 999.0;

  // ── Border widths ─────────────────────────────────────────────────
  static const double hairline = 1.0;
  static const double border = 1.5;

  // ── Hit targets ───────────────────────────────────────────────────
  static const double tapTarget = 40.0;
  static const double tapTargetSm = 32.0;

  // ── Shadow opacities (we keep things flat) ────────────────────────
  static const double elevationOpacityLow = 0.06;
  static const double elevationOpacityMid = 0.12;

  // ── Hairline color helper ─────────────────────────────────────────
  /// Standard hairline border resolved against the current scheme.
  static BoxBorder hairlineBorder(
    ColorScheme scheme, {
    double opacity = 0.30,
  }) =>
      Border.all(
        color: scheme.outlineVariant.withValues(alpha: opacity),
        width: hairline,
      );

  /// Standard hairline `BorderSide` for `OutlinedBorder` shapes.
  static BorderSide hairlineSide(
    ColorScheme scheme, {
    double opacity = 0.30,
  }) =>
      BorderSide(
        color: scheme.outlineVariant.withValues(alpha: opacity),
        width: hairline,
      );
}
