import 'package:flutter/material.dart';

import '../../tokens/wlm_tokens.dart';
import '../../tokens/wlm_type.dart';
import '../buttons/wlm_ghost_button.dart';
import '../buttons/wlm_primary_button.dart';

/// Hairline-outlined alert dialog. Two action slots: primary (filled
/// ink) and ghost. Pass `destructive` to recolor the primary button as
/// the error tone.
class WlmDialog extends StatelessWidget {
  const WlmDialog({
    super.key,
    required this.title,
    required this.body,
    this.confirmLabel = 'CONFIRM',
    this.cancelLabel = 'CANCEL',
    this.onConfirm,
    this.onCancel,
    this.destructive = false,
  });

  final String title;
  final String body;
  final String confirmLabel;
  final String cancelLabel;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final bool destructive;

  static Future<bool?> show(
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
        confirmLabel: confirmLabel,
        cancelLabel: cancelLabel,
        destructive: destructive,
        onConfirm: () => Navigator.of(ctx).pop(true),
        onCancel: () => Navigator.of(ctx).pop(false),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Dialog(
      backgroundColor: scheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(WlmTokens.radXl),
        side: WlmTokens.hairlineSide(scheme),
      ),
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
            const SizedBox(height: WlmTokens.spaceMd),
            Text(
              body,
              style: WlmType.bodySmall(scheme.outline).copyWith(height: 1.5),
            ),
            const SizedBox(height: WlmTokens.spaceXl),
            Row(
              children: [
                WlmGhostButton(label: cancelLabel, onPressed: onCancel),
                const Spacer(),
                WlmPrimaryButton(label: confirmLabel, onPressed: onConfirm),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
