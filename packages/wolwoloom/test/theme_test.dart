import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wolwoloom/wolwoloom.dart';

void main() {
  setUpAll(() {
    TestWidgetsFlutterBinding.ensureInitialized();
    GoogleFonts.config.allowRuntimeFetching = false;
  });

  testWidgets('builds light + dark themes with WlmThemeExtension',
      (tester) async {
    for (final theme in [WlmTheme.light(), WlmTheme.dark()]) {
      final ext = theme.extension<WlmThemeExtension>();
      expect(ext, isNotNull, reason: 'extension registered');
      expect(theme.useMaterial3, isTrue);
      expect(theme.splashFactory, NoSplash.splashFactory);
    }
  });

  testWidgets('extensions expose distinct hairline colors per brightness',
      (tester) async {
    final light = WlmTheme.light().extension<WlmThemeExtension>()!;
    final dark = WlmTheme.dark().extension<WlmThemeExtension>()!;
    expect(light.hairline, isNot(equals(dark.hairline)));
    expect(light.accent, isNot(equals(dark.accent)));
  });
}
