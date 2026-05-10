import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Typography helpers. wloom is mono-typed everywhere — every helper
/// here returns a `JetBrains Mono` `TextStyle` configured for one of the
/// fixed roles (display, h1..h3, body, label, meta, tiny).
///
/// Each helper takes the foreground color explicitly so callers stay in
/// control of contrast and don't need a `BuildContext`.
class WlmType {
  WlmType._();

  static TextStyle mono({
    required double size,
    FontWeight weight = FontWeight.w400,
    Color? color,
    double letterSpacing = 0,
    double? height,
  }) =>
      GoogleFonts.jetBrainsMono(
        fontSize: size,
        fontWeight: weight,
        color: color,
        letterSpacing: letterSpacing,
        height: height,
      );

  /// Hero number / display headline.
  static TextStyle display(Color c) =>
      mono(size: 22, weight: FontWeight.w200, color: c, letterSpacing: -0.5);

  /// Page title.
  static TextStyle h1(Color c) =>
      mono(size: 24, weight: FontWeight.w300, color: c, letterSpacing: -0.5);

  /// Section title.
  static TextStyle h2(Color c) =>
      mono(size: 16, weight: FontWeight.w400, color: c, letterSpacing: -0.2);

  /// Sub-section / list title.
  static TextStyle h3(Color c) =>
      mono(size: 13, weight: FontWeight.w400, color: c, letterSpacing: -0.2);

  static TextStyle body(Color c) =>
      mono(size: 14, weight: FontWeight.w400, color: c);

  static TextStyle bodySmall(Color c) =>
      mono(size: 13, weight: FontWeight.w400, color: c);

  /// Signature ALL-CAPS label (sparse, very small).
  static TextStyle label(Color c) =>
      mono(size: 10, weight: FontWeight.w400, color: c, letterSpacing: 1.2);

  /// Caption / metadata under content.
  static TextStyle meta(Color c) =>
      mono(size: 10, weight: FontWeight.w300, color: c);

  /// Tiny mono caption (chips, focus indicators).
  static TextStyle tiny(Color c) =>
      mono(size: 9, weight: FontWeight.w400, color: c, letterSpacing: 0.4);
}
