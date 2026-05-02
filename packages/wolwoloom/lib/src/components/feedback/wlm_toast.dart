import 'package:flutter/material.dart';

import '../../theme/wlm_theme_extension.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../display/wlm_callout.dart';

/// Lightweight, non-Material toast that floats in from the bottom and
/// dismisses itself. Use for transient notices that don't deserve a
/// full snackbar.
///
/// ```dart
/// WlmToast.show(context, 'Copied', tone: WlmCalloutTone.success);
/// ```
class WlmToast {
  WlmToast._();

  static void show(
    BuildContext context,
    String message, {
    WlmCalloutTone tone = WlmCalloutTone.neutral,
    Duration duration = const Duration(milliseconds: 1800),
  }) {
    final overlay = Overlay.of(context);
    final scheme = Theme.of(context).colorScheme;
    final wlm = WlmThemeExtension.of(context);
    final accent = switch (tone) {
      WlmCalloutTone.info => wlm.info,
      WlmCalloutTone.success => wlm.success,
      WlmCalloutTone.warning => wlm.warning,
      WlmCalloutTone.danger => wlm.danger,
      WlmCalloutTone.neutral => scheme.onSurface,
    };

    final entry = OverlayEntry(
      builder: (ctx) => Positioned(
        left: 0,
        right: 0,
        bottom: MediaQuery.of(ctx).padding.bottom + WlmTokens.spaceXl,
        child: SafeArea(
          child: Center(
            child: _ToastBody(
              message: message,
              tone: accent,
              duration: duration,
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    Future.delayed(duration + const Duration(milliseconds: 300), entry.remove);
  }
}

class _ToastBody extends StatefulWidget {
  const _ToastBody({
    required this.message,
    required this.tone,
    required this.duration,
  });
  final String message;
  final Color tone;
  final Duration duration;

  @override
  State<_ToastBody> createState() => _ToastBodyState();
}

class _ToastBodyState extends State<_ToastBody> {
  double _opacity = 0;
  double _offset = 8;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      setState(() {
        _opacity = 1;
        _offset = 0;
      });
    });
    Future.delayed(widget.duration, () {
      if (!mounted) return;
      setState(() {
        _opacity = 0;
        _offset = 8;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return AnimatedSlide(
      offset: Offset(0, _offset == 0 ? 0 : 0.4),
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 220),
        opacity: _opacity,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: WlmTokens.spaceLg,
              vertical: WlmTokens.spaceSm + 2,
            ),
            decoration: BoxDecoration(
              color: scheme.brightness == Brightness.dark
                  ? scheme.surfaceContainerHighest
                  : Colors.black,
              borderRadius: BorderRadius.circular(WlmTokens.radPill),
              border: Border.all(
                color: widget.tone.withValues(alpha: 0.35),
                width: 1,
              ),
            ),
            child: Text(
              widget.message,
              style: WlmType.bodySmall(Colors.white).copyWith(fontSize: 12.5),
            ),
          ),
        ),
      ),
    );
  }
}
