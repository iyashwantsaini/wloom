import 'package:flutter/material.dart';

/// Fire a Wolwoloom-styled snack bar (the theme has already restyled
/// Material's defaults — this is just a tiny convenience helper).
///
/// ```dart
/// WlmSnack.show(context, 'Saved');
/// WlmSnack.show(context, 'Synced', actionLabel: 'UNDO', onAction: undo);
/// ```
class WlmSnack {
  WlmSnack._();

  static void show(
    BuildContext context,
    String message, {
    Duration duration = const Duration(milliseconds: 1800),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.hideCurrentSnackBar();
    messenger.showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: actionLabel == null
            ? null
            : SnackBarAction(
                label: actionLabel.toUpperCase(),
                onPressed: onAction ?? () {},
              ),
      ),
    );
  }
}
