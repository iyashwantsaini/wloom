import 'package:flutter/material.dart';

/// Raw color palette behind [WlmTheme]. Exposed for cases where you need
/// to drop a brand color outside a `Theme.of(context).colorScheme` lookup
/// (gradients, marketing surfaces, custom illustrations).
///
/// Prefer `Theme.of(context).colorScheme` everywhere else — it is what
/// every wloom component reads from.
class WlmColors {
  WlmColors._();

  // ── Dark palette ──────────────────────────────────────────────────
  static const Color ink = Color(0xFF0A0A0A);
  static const Color surfaceDark = Color(0xFF111114);
  static const Color surfaceDarkElev = Color(0xFF17171B);
  static const Color onDark = Color(0xFFEDEEF2);
  static const Color mutedDark = Color(0xFF7A7A82);
  static const Color hairlineDark = Color(0xFF2A2A30);

  // ── Light palette ─────────────────────────────────────────────────
  static const Color paper = Color(0xFFF4F4F6);
  static const Color paperElev = Color(0xFFFFFFFF);
  static const Color inkLight = Color(0xFF0E0E14);
  static const Color mutedLight = Color(0xFF6B6B73);
  static const Color hairlineLight = Color(0xFFE3E3E8);

  // ── Accent (periwinkle) ───────────────────────────────────────────
  static const Color accentDark = Color(0xFF8FA8FF);
  static const Color accentLight = Color(0xFF4A5BD0);

  // ── Status ────────────────────────────────────────────────────────
  static const Color error = Color(0xFFB3261E);
  static const Color success = Color(0xFF2E7D32);
  static const Color warning = Color(0xFFB26A00);
}
