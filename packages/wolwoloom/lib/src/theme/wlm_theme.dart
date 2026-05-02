import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import '../tokens/wlm_colors.dart';
import '../tokens/wlm_tokens.dart';
import 'wlm_theme_extension.dart';

/// Wolwoloom theme builders.
///
/// ```dart
/// MaterialApp(
///   theme: WlmTheme.light(),
///   darkTheme: WlmTheme.dark(),
///   themeMode: ThemeMode.system,
/// );
/// ```
class WlmTheme {
  const WlmTheme._();

  static ThemeData light() {
    final base = ThemeData.light(useMaterial3: true);
    const scheme = ColorScheme(
      brightness: Brightness.light,
      primary: WlmColors.inkLight,
      onPrimary: WlmColors.paperElev,
      secondary: WlmColors.accentLight,
      onSecondary: WlmColors.paperElev,
      error: WlmColors.error,
      onError: WlmColors.paperElev,
      surface: WlmColors.paper,
      onSurface: WlmColors.inkLight,
      surfaceContainerHighest: WlmColors.paperElev,
      onSurfaceVariant: WlmColors.mutedLight,
      outline: WlmColors.mutedLight,
      outlineVariant: WlmColors.hairlineLight,
      shadow: Color(0x14000000),
    );
    return _applyCommon(
      base,
      scheme,
      surface: WlmColors.paper,
      surfaceElev: WlmColors.paperElev,
      onSurface: WlmColors.inkLight,
      muted: WlmColors.mutedLight,
      hairline: WlmColors.hairlineLight,
      accent: WlmColors.accentLight,
      statusBarBrightness: Brightness.dark,
      extension: WlmThemeExtension.light,
    );
  }

  static ThemeData dark() {
    final base = ThemeData.dark(useMaterial3: true);
    final scheme = ColorScheme.fromSeed(
      seedColor: WlmColors.accentDark,
      brightness: Brightness.dark,
      surface: WlmColors.ink,
    ).copyWith(
      surface: WlmColors.ink,
      surfaceContainerHighest: WlmColors.surfaceDarkElev,
      primary: WlmColors.accentDark,
      onPrimary: WlmColors.ink,
      secondary: WlmColors.accentDark,
      onSurface: WlmColors.onDark,
      onSurfaceVariant: WlmColors.mutedDark,
      outline: WlmColors.mutedDark,
      outlineVariant: WlmColors.hairlineDark,
    );
    return _applyCommon(
      base,
      scheme,
      surface: WlmColors.ink,
      surfaceElev: WlmColors.surfaceDarkElev,
      onSurface: WlmColors.onDark,
      muted: WlmColors.mutedDark,
      hairline: WlmColors.hairlineDark,
      accent: WlmColors.accentDark,
      statusBarBrightness: Brightness.light,
      extension: WlmThemeExtension.dark,
    );
  }

  static ThemeData _applyCommon(
    ThemeData base,
    ColorScheme scheme, {
    required Color surface,
    required Color surfaceElev,
    required Color onSurface,
    required Color muted,
    required Color hairline,
    required Color accent,
    required Brightness statusBarBrightness,
    required WlmThemeExtension extension,
  }) {
    return base.copyWith(
      extensions: <ThemeExtension<dynamic>>[extension],
      colorScheme: scheme,
      scaffoldBackgroundColor: surface,
      canvasColor: surface,
      textTheme: GoogleFonts.jetBrainsMonoTextTheme(base.textTheme).apply(
        bodyColor: onSurface,
        displayColor: onSurface,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        scrolledUnderElevation: 0,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: statusBarBrightness,
        ),
      ),
      cardTheme: CardThemeData(
        color: surfaceElev,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WlmTokens.radXl),
          side: BorderSide(color: hairline, width: WlmTokens.hairline),
        ),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: surfaceElev,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: scheme.primary,
        unselectedItemColor: muted,
      ),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? surfaceElev : muted,
        ),
        trackColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? onSurface : surface,
        ),
        trackOutlineColor: WidgetStatePropertyAll(hairline),
        trackOutlineWidth: const WidgetStatePropertyAll(1),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? onSurface : Colors.transparent,
        ),
        checkColor: WidgetStatePropertyAll(surfaceElev),
        side: BorderSide(color: muted, width: 1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      ),
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected) ? onSurface : muted,
        ),
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: accent,
        selectionColor: accent.withValues(alpha: 0.20),
        selectionHandleColor: accent,
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.brightness == Brightness.dark ? surfaceElev : WlmColors.ink,
        contentTextStyle: GoogleFonts.jetBrainsMono(
          color: WlmColors.onDark,
          fontSize: 12.5,
          fontWeight: FontWeight.w500,
          letterSpacing: 0.2,
        ),
        actionTextColor: accent,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(WlmTokens.radMd),
          side: BorderSide(
            color: accent.withValues(alpha: 0.35),
            width: WlmTokens.hairline,
          ),
        ),
        insetPadding: const EdgeInsets.fromLTRB(
          WlmTokens.spaceLg,
          0,
          WlmTokens.spaceLg,
          WlmTokens.spaceXl,
        ),
      ),
      dividerColor: hairline,
      dividerTheme: DividerThemeData(
        color: hairline,
        space: WlmTokens.hairline,
        thickness: WlmTokens.hairline,
      ),
      iconTheme: IconThemeData(color: onSurface),
      splashFactory: NoSplash.splashFactory,
      highlightColor: Colors.transparent,
      hoverColor: onSurface.withValues(alpha: 0.04),
    );
  }
}
