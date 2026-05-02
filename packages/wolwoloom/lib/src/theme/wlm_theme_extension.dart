import 'package:flutter/material.dart';

import '../tokens/wlm_colors.dart';

/// Typed access to Wolwoloom-specific tokens via `Theme.of(context)`.
///
/// ```dart
/// final wlm = Theme.of(context).extension<WlmThemeExtension>()!;
/// container( color: wlm.hairline, ... );
/// ```
@immutable
/// Wolwoloom theme extension class.
class WlmThemeExtension extends ThemeExtension<WlmThemeExtension> {
  const WlmThemeExtension({
    required this.hairline,
    required this.muted,
    required this.accent,
    required this.success,
    required this.warning,
    required this.danger,
    required this.info,
  });

  /// Convenience accessor for the active extension.
  static WlmThemeExtension of(BuildContext context) =>
      Theme.of(context).extension<WlmThemeExtension>()!;

  final Color hairline;
  final Color muted;
  final Color accent;
  final Color success;
  final Color warning;
  final Color danger;
  final Color info;

  static const light = WlmThemeExtension(
    hairline: WlmColors.hairlineLight,
    muted: WlmColors.mutedLight,
    accent: WlmColors.accentLight,
    success: WlmColors.success,
    warning: WlmColors.warning,
    danger: WlmColors.error,
    info: WlmColors.accentLight,
  );

  static const dark = WlmThemeExtension(
    hairline: WlmColors.hairlineDark,
    muted: WlmColors.mutedDark,
    accent: WlmColors.accentDark,
    success: WlmColors.success,
    warning: WlmColors.warning,
    danger: WlmColors.error,
    info: WlmColors.accentDark,
  );

  @override
  WlmThemeExtension copyWith({
    Color? hairline,
    Color? muted,
    Color? accent,
    Color? success,
    Color? warning,
    Color? danger,
    Color? info,
  }) =>
      WlmThemeExtension(
        hairline: hairline ?? this.hairline,
        muted: muted ?? this.muted,
        accent: accent ?? this.accent,
        success: success ?? this.success,
        warning: warning ?? this.warning,
        danger: danger ?? this.danger,
        info: info ?? this.info,
      );

  @override
  WlmThemeExtension lerp(ThemeExtension<WlmThemeExtension>? other, double t) {
    if (other is! WlmThemeExtension) return this;
    return WlmThemeExtension(
      hairline: Color.lerp(hairline, other.hairline, t)!,
      muted: Color.lerp(muted, other.muted, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      success: Color.lerp(success, other.success, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      info: Color.lerp(info, other.info, t)!,
    );
  }
}
