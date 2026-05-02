import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../buttons/wlm_button.dart';
import '../buttons/wlm_ghost_button.dart';
import '../buttons/wlm_primary_button.dart';

/// Hairline-outlined alert dialog.
///
/// Three usage modes:
///  * [WlmDialog.confirm] — title + body + cancel/confirm buttons
///    (returns `true` on confirm).
///  * [WlmDialog.alert] — title + body + single OK button.
///  * [WlmDialog.custom] — drop your own widget tree inside the
///    standard chrome (use for forms, settings panels, etc).
class WlmDialog extends StatelessWidget {
  const WlmDialog({
    super.key,
    required this.title,
    this.body,
    this.child,
    this.actions = const [],
    this.maxWidth = 420,
  });

  final String title;
  final String? body;
  final Widget? child;
  final List<Widget> actions;
  final double maxWidth;

  /// Confirm/cancel dialog. Returns `true` when confirmed, `false`
  /// when cancelled, `null` when dismissed.
  static Future<bool?> confirm(
    BuildContext context, {
    required String title,
    required String body,
    String confirmLabel = 'CONFIRM',
    String cancelLabel = 'CANCEL',
    bool destructive = false,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (ctx) => WlmDialog(
        title: title,
        body: body,
        actions: [
          WlmGhostButton(
              label: cancelLabel,
              onPressed: () => Navigator.of(ctx).pop(false),),
          const SizedBox(width: WlmTokens.spaceSm),
          WlmButton(
            label: confirmLabel,
            variant: destructive
                ? WlmButtonVariant.destructive
                : WlmButtonVariant.primary,
            onPressed: () => Navigator.of(ctx).pop(true),
          ),
        ],
      ),
    );
  }

  /// Single-button informational dialog.
  static Future<void> alert(
    BuildContext context, {
    required String title,
    required String body,
    String okLabel = 'OK',
  }) {
    return showDialog<void>(
      context: context,
      builder: (ctx) => WlmDialog(
        title: title,
        body: body,
        actions: [
          WlmPrimaryButton(
              label: okLabel, onPressed: () => Navigator.of(ctx).pop(),),
        ],
      ),
    );
  }

  /// Custom-content dialog.
  static Future<T?> custom<T>(
    BuildContext context, {
    required String title,
    required Widget child,
    List<Widget> actions = const [],
    double maxWidth = 420,
  }) {
    return showDialog<T>(
      context: context,
      builder: (ctx) => WlmDialog(
        title: title,
        actions: actions,
        maxWidth: maxWidth,
        child: child,
      ),
    );
  }

  /// Backwards-compatible wrapper for the old `WlmDialog.show(...)` call.
  /// Delegates to [WlmDialog.confirm].
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String body,
    String confirmLabel = 'CONFIRM',
    String cancelLabel = 'CANCEL',
    bool destructive = false,
  }) =>
      confirm(
        context,
        title: title,
        body: body,
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        destructive: destructive,
      );

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Dialog(
      backgroundColor: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WlmTokens.radXl),
        side: WlmTokens.hairlineSide(scheme),
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
            WlmTokens.spaceXl,
            WlmTokens.spaceXl,
            WlmTokens.spaceXl,
            WlmTokens.spaceLg,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: WlmType.h2(scheme.onSurface)),
              if (body != null) ...[
                const SizedBox(height: WlmTokens.spaceMd),
                Text(
                  body!,
                  style:
                      WlmType.bodySmall(scheme.outline).copyWith(height: 1.5),
                ),
              ],
              if (child != null) ...[
                const SizedBox(height: WlmTokens.spaceLg),
                child!,
              ],
              if (actions.isNotEmpty) ...[
                const SizedBox(height: WlmTokens.spaceXl),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: actions,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
