import 'dart:async';

import 'package:flutter/material.dart';

import '../../theme/wlm_theme_extension.dart';
import '../../tokens/wlm_motion.dart';
import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../display/wlm_callout.dart';

/// Single toast model.
class WlmToastEntry {
  WlmToastEntry({
    required this.message,
    this.title,
    this.tone = WlmCalloutTone.neutral,
    this.duration = const Duration(seconds: 4),
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final String? title;
  final WlmCalloutTone tone;
  final Duration duration;
  final String? actionLabel;
  final VoidCallback? onAction;

  final _id = UniqueKey();
}

/// Sonner-style stacking toaster. Render once near the root of your app
/// (above `MaterialApp.builder`'s child) and call
/// [WlmToaster.show] from anywhere with a [BuildContext].
///
/// ```dart
/// MaterialApp(
///   builder: (ctx, child) => WlmToaster(child: child!),
/// );
/// ...
/// WlmToaster.show(context, WlmToastEntry(message: 'Saved'));
/// ```
class WlmToaster extends StatefulWidget {
  const WlmToaster({
    super.key,
    required this.child,
    this.maxVisible = 4,
    this.alignment = Alignment.bottomCenter,
  });

  final Widget child;
  final int maxVisible;
  final Alignment alignment;

  static WlmToasterState? maybeOf(BuildContext context) =>
      context.findAncestorStateOfType<WlmToasterState>();

  static WlmToasterState of(BuildContext context) {
    final s = maybeOf(context);
    assert(s != null,
        'No WlmToaster found in context. Wrap your app with WlmToaster.',);
    return s!;
  }

  /// Show a toast. The toaster ancestor must exist.
  static void show(BuildContext context, WlmToastEntry entry) =>
      of(context).push(entry);

  /// Convenience wrappers.
  static void info(BuildContext context, String message,
          {String? title, Duration? duration,}) =>
      show(
          context,
          WlmToastEntry(
            message: message,
            title: title,
            tone: WlmCalloutTone.info,
            duration: duration ?? const Duration(seconds: 4),
          ),);

  static void success(BuildContext context, String message,
          {String? title, Duration? duration,}) =>
      show(
          context,
          WlmToastEntry(
            message: message,
            title: title,
            tone: WlmCalloutTone.success,
            duration: duration ?? const Duration(seconds: 4),
          ),);

  static void warning(BuildContext context, String message,
          {String? title, Duration? duration,}) =>
      show(
          context,
          WlmToastEntry(
            message: message,
            title: title,
            tone: WlmCalloutTone.warning,
            duration: duration ?? const Duration(seconds: 5),
          ),);

  static void danger(BuildContext context, String message,
          {String? title, Duration? duration,}) =>
      show(
          context,
          WlmToastEntry(
            message: message,
            title: title,
            tone: WlmCalloutTone.danger,
            duration: duration ?? const Duration(seconds: 6),
          ),);

  @override
  State<WlmToaster> createState() => WlmToasterState();
}

/// wloom toaster state class.
class WlmToasterState extends State<WlmToaster> {
  final List<WlmToastEntry> _entries = [];
  final Map<Key, Timer> _timers = {};

  void push(WlmToastEntry entry) {
    setState(() => _entries.add(entry));
    _timers[entry._id] = Timer(entry.duration, () => dismiss(entry));
  }

  void dismiss(WlmToastEntry entry) {
    _timers.remove(entry._id)?.cancel();
    if (mounted) setState(() => _entries.remove(entry));
  }

  @override
  void dispose() {
    for (final t in _timers.values) {
      t.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final visible = _entries.length > widget.maxVisible
        ? _entries.sublist(_entries.length - widget.maxVisible)
        : _entries;
    final isBottom = widget.alignment.y > 0;
    return Stack(
      children: [
        widget.child,
        Positioned.fill(
          child: SafeArea(
            child: Align(
              alignment: widget.alignment,
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 380),
                child: Padding(
                  padding: const EdgeInsets.all(WlmTokens.spaceLg),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final entry
                          in (isBottom ? visible : visible.reversed))
                        Padding(
                          key: ValueKey(entry._id),
                          padding: const EdgeInsets.only(top: WlmTokens.spaceSm),
                          child: _ToastTile(
                            entry: entry,
                            onDismiss: () => dismiss(entry),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _ToastTile extends StatefulWidget {
  const _ToastTile({required this.entry, required this.onDismiss});
  final WlmToastEntry entry;
  final VoidCallback onDismiss;

  @override
  State<_ToastTile> createState() => _ToastTileState();
}

class _ToastTileState extends State<_ToastTile>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctl;

  @override
  void initState() {
    super.initState();
    _ctl = AnimationController(
      vsync: this,
      duration: WlmMotion.medium,
    )..forward();
  }

  @override
  void dispose() {
    _ctl.dispose();
    super.dispose();
  }

  Color _toneColor(BuildContext c) {
    final wlm = WlmThemeExtension.of(c);
    return switch (widget.entry.tone) {
      WlmCalloutTone.info => wlm.info,
      WlmCalloutTone.success => wlm.success,
      WlmCalloutTone.warning => wlm.warning,
      WlmCalloutTone.danger => wlm.danger,
      WlmCalloutTone.neutral => Theme.of(c).colorScheme.onSurface,
    };
  }

  IconData _toneIcon() => switch (widget.entry.tone) {
        WlmCalloutTone.info => Icons.info_outline_rounded,
        WlmCalloutTone.success => Icons.check_circle_outline_rounded,
        WlmCalloutTone.warning => Icons.warning_amber_rounded,
        WlmCalloutTone.danger => Icons.error_outline_rounded,
        WlmCalloutTone.neutral => Icons.notes_rounded,
      };

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final c = _toneColor(context);
    return SlideTransition(
      position: Tween(begin: const Offset(0, 0.3), end: Offset.zero)
          .chain(CurveTween(curve: WlmMotion.standard))
          .animate(_ctl),
      child: FadeTransition(
        opacity: _ctl,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(WlmTokens.spaceMd),
            decoration: BoxDecoration(
              color: scheme.surface,
              borderRadius: BorderRadius.circular(WlmTokens.radMd),
              border: Border.all(color: c.withValues(alpha: 0.4), width: 1),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.10),
                  blurRadius: 24,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(_toneIcon(), size: 16, color: c),
                const SizedBox(width: WlmTokens.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.entry.title != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 2),
                          child: Text(widget.entry.title!,
                              style: WlmType.h3(scheme.onSurface)
                                  .copyWith(fontSize: 13),),
                        ),
                      Text(widget.entry.message,
                          style: WlmType.bodySmall(scheme.onSurfaceVariant)
                              .copyWith(height: 1.4),),
                    ],
                  ),
                ),
                if (widget.entry.actionLabel != null) ...[
                  const SizedBox(width: WlmTokens.spaceSm),
                  GestureDetector(
                    onTap: () {
                      widget.entry.onAction?.call();
                      widget.onDismiss();
                    },
                    child: Text(
                      widget.entry.actionLabel!.toUpperCase(),
                      style:
                          WlmType.label(c).copyWith(letterSpacing: 1.2),
                    ),
                  ),
                ],
                const SizedBox(width: WlmTokens.spaceSm),
                GestureDetector(
                  onTap: widget.onDismiss,
                  child: Icon(Icons.close_rounded,
                      size: 14, color: scheme.outline,),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
