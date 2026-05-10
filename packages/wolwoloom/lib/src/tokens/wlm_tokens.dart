import 'package:flutter/material.dart';

/// Spacing, radii, border and tap-target tokens used by every wloom
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

  // ── Semantic spacing aliases ──────────────────────────────────────
  /// Standard horizontal page gutter (= [spaceLg]).
  static const double gutter = spaceLg;
  /// Vertical separation between page sections (= [spaceXxl]).
  static const double section = spaceXxl;
  /// Default inner padding for `WlmCard` and similar surfaces (= [spaceLg]).
  static const double cardPadding = spaceLg;
  /// Inset applied to inline form rows (= [spaceMd]).
  static const double inlineGap = spaceMd;

  // ── Radii ─────────────────────────────────────────────────────────
  static const double radXs = 4.0;
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
  static const double elevationOpacityHigh = 0.18;

  // ── Elevation scale ───────────────────────────────────────────────
  /// Subtle lift — chips, hovered surfaces.
  static List<BoxShadow> shadowSm(ColorScheme scheme) => [
        BoxShadow(
          color: scheme.shadow.withValues(alpha: elevationOpacityLow),
          blurRadius: 4,
          offset: const Offset(0, 1),
        ),
      ];

  /// Standard lift — bottom sheets, cards on scroll.
  static List<BoxShadow> shadowMd(ColorScheme scheme) => [
        BoxShadow(
          color: scheme.shadow.withValues(alpha: elevationOpacityMid),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ];

  /// Heavy lift — dialogs, command palette.
  static List<BoxShadow> shadowLg(ColorScheme scheme) => [
        BoxShadow(
          color: scheme.shadow.withValues(alpha: elevationOpacityHigh),
          blurRadius: 24,
          offset: const Offset(0, 8),
        ),
      ];

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
